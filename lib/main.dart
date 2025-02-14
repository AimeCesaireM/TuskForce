import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SignIn/sign_in_screen.dart';
import 'frame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TuskForce',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(),
        colorSchemeSeed: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          elevation: 4.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 20,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          backgroundColor: Colors.deepPurple.shade200,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text(
                  'Error loading TuskForce.',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Roboto',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }

          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Scaffold(
                  body: Center(
                    child: Text(
                      'Error loading TuskForce.',
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }

              User? user = snapshot.data;

              return user == null ? SignInScreen() : Frame();
            },
          );
        },
      ),
    );
  }
}
