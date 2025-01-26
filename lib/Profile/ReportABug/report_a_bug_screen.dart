import 'package:flutter/material.dart';

class ReportABugScreen extends StatelessWidget {
  const ReportABugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report a Bug'),
      ),
      body: Center(
        child: Text('Report a Bug Screen'),
      ),
    );
  }
}