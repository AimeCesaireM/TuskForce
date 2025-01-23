import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Services/global_methods.dart';
import 'optional_profile_picture_screen.dart';

class OptionalUsernameScreen extends StatefulWidget {
  final Map<String, String> data;

  const OptionalUsernameScreen({required this.data, super.key});

  @override
  State<OptionalUsernameScreen> createState() => _OptionalUsernameScreenState();
}

class _OptionalUsernameScreenState extends State<OptionalUsernameScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  void _submitUsername(String username) async {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      setState(() {
        _isLoading = true;
      });

      try {
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        if (username.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_uid)
              .update({
            'username': username,
          });
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethods.showErrorDialog(error: error.toString(), ctx: context);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose a Username ")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Would you like to set a username?',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Stand out with a unique username. Use the handle associated with your '
                'work on other platforms so Tuskers can find you!',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _usernameController,
                decoration:
                    const InputDecoration(labelText: 'Username (Optional)'),
                maxLength: 20,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (value.length < 3) {
                      return 'Username must be at least 3 and at most 20 characters long';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                      return 'Only letters, numbers, and underscores are allowed';
                    }
                  }
                  return null;
                },
                onChanged: (value) {
                  _formKey.currentState!.validate();
                },
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.deepPurple,
                        )
                      : FloatingActionButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final username =
                                  _usernameController.text.trim().toLowerCase();
                              _submitUsername(username);
                              // Navigate to the next screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OptionalProfilePictureScreen(), // Replace with the actual next screen
                                ),
                              );
                            }
                          },
                          child: const Icon(Icons.arrow_forward,
                              color: Colors.white),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
