import 'package:flutter/material.dart';

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
                decoration: const InputDecoration(labelText: 'Username (Optional)'),
                maxLength: 20,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (value.length < 3) {
                      return 'Username must be at least 3 characters long';
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
                  FloatingActionButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final username = _usernameController.text.trim();
                        final userData = {
                          ...widget.data,
                          if (username.isNotEmpty) 'username': username,
                        };
                        // Navigate to the next screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OptionalProfilePictureScreen(data: userData), // Replace with the actual next screen
                          ),
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward, color: Colors.white),
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
