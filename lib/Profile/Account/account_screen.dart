import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  void _updateProfilePicture() {
    // Handle profile picture update
  }

  void _editProfile() {
    // Handle profile edit
  }

  void _logout() {
    // Handle logout
  }

  void _deleteAccount() {
    // Handle account deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey,
                    child: Icon(Icons.camera_alt_outlined, size: 50), // Placeholder camera icon
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage('assets/profile_picture.png'), // Replace with your profile picture asset
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _updateProfilePicture,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe', // Replace with actual name
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '@johndoe', // Replace with actual username
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.email_outlined),
                    title: Text('john.doe@example.com'), // Replace with actual email
                  ),
                  ListTile(
                    leading: Icon(Icons.phone_outlined),
                    title: Text('+1 234 567 890'), // Replace with actual phone number
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: _editProfile,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        side: BorderSide(color: Colors.black),
                      ),
                      child: Text('Edit', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: _logout,
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Make button span the entire width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                side: BorderSide(color: Colors.black),
              ),
              child: Text('Logout', style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: _deleteAccount,
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Make button span the entire width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                side: BorderSide(color: Colors.red.shade900),
              ),
              child: Text('Delete My Account', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}