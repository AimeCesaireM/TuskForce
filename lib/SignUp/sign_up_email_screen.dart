import 'package:flutter/material.dart';
import 'package:tusk_force/SignUp/sign_up_password_screen.dart';

class SignUpEmailScreen extends StatefulWidget {
  final Map<String, String> data;

  const SignUpEmailScreen({required this.data, super.key});

  @override
  State<SignUpEmailScreen> createState() => _SignUpEmailScreenState();
}

class _SignUpEmailScreenState extends State<SignUpEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up - Email")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Enter your email address',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _emailTextController,
                decoration: const InputDecoration(labelText: 'Amherst Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!value.contains('@amherst.edu')) {
                    return 'Enter a valid Amherst College email address';
                  }
                  return null;
                },
                onChanged: (value) {
                  _formKey.currentState!.validate();
                },
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Proceed to next screen with the email data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPasswordScreen(
                            data: {
                              ...widget.data,
                              'email': _emailTextController.text,
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,

                  ),
                  )
                ),
            ],
          ),
        ),
      ),
    );
  }
}
