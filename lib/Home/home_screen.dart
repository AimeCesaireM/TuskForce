import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tusk_force/bottom_nav_bar_frame.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return _auth.currentUser != null? Scaffold(
      appBar: AppBar(),
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: 150, horizontal: 20),
      child: Column(
        children: [
          Text(_auth.currentUser!.email!),
          Text(_auth.currentUser!.displayName!),
          Text(_auth.currentUser!.photoURL!),
          Text(_auth.currentUser!.uid),
        ],
      ),
    ),
      // bottomNavigationBar: BottomNavBarFrame(),

    )
        : Scaffold(

    );
  }
}
