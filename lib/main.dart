import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Services/global_variables.dart';
import 'LoginPage/login_screen.dart';

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
            return MaterialApp(home: Scaffold(
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
                scaffoldBackgroundColor: Colors.deepPurple.shade100,
                primarySwatch: Colors.blue,
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.blue,
                ).copyWith(
                  secondary: Colors.amber, // Accent color
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),

              ),

              home: Login());
        });
  }
}
