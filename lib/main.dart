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
            return const MaterialApp(
                home: Scaffold(
                    body: Center(
                        child: Text('Loading Tusks...',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto')))));
          } else if (snapshot.hasError) {
            return const MaterialApp(
                home: Scaffold(
                    body: Center(
                        child: Text('Oops! Error loading your Tusks',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 40,
                                fontWeight: FontWeight.bold)))));
          }
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tusk Force',
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.blueGrey.shade800,
                primarySwatch: Colors.blue,
              ),
              home: Login()
          );
        });
  }
}
