import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return  ListView(
        children: [
          Text(_auth.currentUser!.email!),
          Text(_auth.currentUser!.displayName!),
          Text(_auth.currentUser!.photoURL!),
          Text(_auth.currentUser!.uid),
        ],
      );
  }
}
