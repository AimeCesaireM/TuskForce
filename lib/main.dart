import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Home/home_screen.dart';
import 'SignUp/sign_in_screen.dart';
import 'bottom_nav_bar_frame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'TF',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Roboto',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
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
            ),
          );
        }

        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const MaterialApp(
                home: Scaffold(
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
                ),
              );
            }

            User? user = snapshot.data;

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'TuskForce',
              theme: ThemeData(
                textTheme: GoogleFonts.robotoTextTheme(),
                scaffoldBackgroundColor: Colors.orange.shade100,
                primarySwatch: Colors.blue,
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.blue,
                ).copyWith(
                  secondary: Colors.amber,
                ),
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.deepPurple,
                  elevation: 4.0,
                  centerTitle: true,
                  titleTextStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
              home: user == null ? SignInScreen() : BottomNavBarFrame(),
            );
          },
        );
      },
    );
  }
}