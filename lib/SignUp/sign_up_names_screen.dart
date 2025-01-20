import 'package:flutter/material.dart';
import 'package:tusk_force/SignUp/sign_up_email_screen.dart';

class SignUpNamesScreen extends StatefulWidget {
  @override
  State<SignUpNamesScreen> createState() => _SignUpNamesScreenState();
}

class _SignUpNamesScreenState extends State<SignUpNamesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final _lastNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Sign Up - Names")),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text(
                    'Enter your first and last name',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _firstNameController,
                    onEditingComplete: () => FocusScope.of(context).requestFocus(_lastNameFocusNode),
                    decoration: const InputDecoration(labelText: 'First Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'First name is required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },

                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _lastNameController,
                    focusNode: _lastNameFocusNode,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Last name is required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                  ),
                  const SizedBox(height: 80),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpEmailScreen(
                                  data: {
                                    'firstName': _firstNameController.text,
                                    'lastName': _lastNameController.text,
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
                      ),
                    )
                ],
              ),
            ),
          ),
        ]));
  }
}
