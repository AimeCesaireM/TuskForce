import 'package:flutter/material.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Offers'),
      ),
      body: Center(
        child: Text('My Offers Screen'),
      ),
    );
  }
}