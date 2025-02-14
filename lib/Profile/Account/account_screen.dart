import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isEditing = false;
  final TextEditingController _displaynameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displaynameController.text = _auth.currentUser?.displayName ?? 'User Name';
    _phoneNumberController.text =
        _auth.currentUser?.phoneNumber ?? 'Add a Phone Number (optional)';
  }

  void _updateProfilePicture() {
    // Handle profile picture update
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    // Handle save profile
    setState(() {
      _isEditing = false;
    });
    Fluttertoast.showToast(
      msg: 'Profile updated',
      toastLength: Toast.LENGTH_LONG,
    );
  }

  void _logout(BuildContext context) {
    _showConfirmationDialog(
      context,
      'Logout',
      'Are you sure you want to logout?',
      () async {
        _auth.signOut();
        // Handle logout action
        Navigator.of(context).pop(); // Close the dialog
        Navigator.of(context).canPop() ? Navigator.of(context).pop() : null;

        await Fluttertoast.showToast(
          msg: 'Logged out',
          toastLength: Toast.LENGTH_LONG,
        );
      },
    );
  }

  void _deleteAccount(BuildContext context) {
    _showConfirmationDialog(
      context,
      'Delete Account',
      'Are you sure you want to delete your account? This action cannot be undone.',
      () async {
        try {
          await _auth.currentUser?.delete();
          // Handle account deletion action
          Navigator.of(context).pop(); // Close the dialog
          Navigator.of(context).canPop() ? Navigator.of(context).pop() : null;

          Fluttertoast.showToast(
            msg: 'Account deleted',
            toastLength: Toast.LENGTH_LONG,
          );
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete account: $error')),
          );
        }
      },
    );
  }

  void _showConfirmationDialog(
      BuildContext context, String title, String content, VoidCallback onYes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: onYes,
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey,
                    child: Icon(Icons.camera_alt_outlined,
                        size: 50), // Placeholder camera icon
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
                  _isEditing
                      ? TextField(
                          controller: _displaynameController,
                          decoration:
                              InputDecoration(labelText: 'Display Name'),
                        )
                      : Text(
                          _auth.currentUser?.displayName ?? 'User Name',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                  SizedBox(height: 10),
                  _isEditing
                      ? TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(labelText: 'Username'),
                        )
                      : Text(
                          '@ ${_auth.currentUser?.displayName ?? 'user_name'}',
                          // Replace with actual username
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold),
                        ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.email_outlined),
                    title: Text(_auth.currentUser?.email ??
                        'user_email'), // Replace with actual email
                  ),
                  ListTile(
                    leading: Icon(Icons.phone_outlined),
                    title: _isEditing
                        ? TextField(
                            controller: _phoneNumberController,
                            decoration:
                                InputDecoration(labelText: 'Phone Number'),
                          )
                        : Text(_auth.currentUser?.phoneNumber ??
                            'Add a Phone Number (optional)'), // Replace with actual phone number
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: _isEditing ? _saveProfile : _toggleEdit,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        side: BorderSide(color: Colors.black),
                      ),
                      child: Text(_isEditing ? 'Save' : 'Edit',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => _logout(context),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                // Make button span the entire width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                side: BorderSide(color: Colors.black),
              ),
              child: Text('Logout', style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => _deleteAccount(context),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                // Make button span the entire width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                side: BorderSide(color: Colors.red.shade900),
              ),
              child: Text('Delete My Account',
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
