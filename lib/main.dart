import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tusk_force/PostSignUp/optional_username_screen.dart';
import '../Services/global_variables.dart';
import 'Login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
                home: Scaffold(
              body: Center(
                child: Text(
                  'Loading TuskForce...',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Roboto',
                    fontSize: 30,
                  ),
                ),
              ),
            ));
          } else if (snapshot.hasError) {
            return const MaterialApp(
                home: Scaffold(
                    body: Center(
                        child: Text('Error loading TuskForce.',
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Roboto',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )))));
          }
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'TuskForce',
              theme: ThemeData(
                textTheme: GoogleFonts.robotoTextTheme(),
                scaffoldBackgroundColor: Colors.purple.shade100,
                primarySwatch: Colors.blue,
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.blue,
                ).copyWith(
                  secondary: Colors.amber, // Accent color
                ),
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white70, // AppBar background color
                  foregroundColor: Colors.deepPurple.shade900, // Text and icon color
                  elevation: 4.0, // Shadow below the AppBar
                  centerTitle: true, // Centers the title
                  titleTextStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              // home: OptionalUsernameScreen(data: {})
            home: OptionalUsernameScreen(data: {}),
          );
        });
  }
}
