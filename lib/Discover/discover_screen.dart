import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});


  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Text(_auth.currentUser!.email!),
          Text(_auth.currentUser!.displayName!),
          Text(_auth.currentUser!.photoURL!),
          Text(_auth.currentUser!.uid),
        ],
      );
  }
}
