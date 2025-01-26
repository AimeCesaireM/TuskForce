import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                // backgroundImage: AssetImage('assets/profile_picture.png'), // Replace with your profile picture asset
              ),
            ),
            SizedBox(height: 20),
            Text(
              'John Doe', // Replace with actual name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '@johndoe', // Replace with actual username
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('john.doe@example.com'), // Replace with actual email
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+1 234 567 890'), // Replace with actual phone number
            ),
          ],
        ),
      ),
    );
  }
}