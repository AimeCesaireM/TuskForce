import 'package:flutter/material.dart';
import 'package:tusk_force/Login/login_screen.dart';

class SignUpPasswordScreen extends StatefulWidget {
  final Map<String, String> data;

  const SignUpPasswordScreen({required this.data, super.key});

  @override
  State<SignUpPasswordScreen> createState() => _SignUpPasswordScreenState();
}

class _SignUpPasswordScreenState extends State<SignUpPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passTextController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  final _confirmPassFocusNode = FocusNode();

  bool _obscureTextNew = true;
  bool _obscureTextConfirm = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _passTextController.dispose();
    _confirmPassController.dispose();
    _confirmPassFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up - Step 2")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Create your new password',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                  obscureText: _obscureTextNew,
                  controller: _passTextController,
                  onEditingComplete: () => FocusScope.of(context)
                      .requestFocus(_confirmPassFocusNode),
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureTextNew = !_obscureTextNew;
                        });
                      },
                      child: Icon(
                        _obscureTextNew
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    if (value.contains(' ')) {
                      return 'Password cannot contain spaces';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  obscureText: _obscureTextConfirm,
                  controller: _confirmPassController,
                  focusNode: _confirmPassFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureTextConfirm = !_obscureTextConfirm;
                        });
                      },
                      child: Icon(
                        _obscureTextConfirm
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm your password';
                    }
                    if (value != _passTextController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  }),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Proceed with final form submission logic
                      // You can now access email and password via widget.data

                      // print('Email: ${widget.data['email']}');
                      // print('Password: ${_passTextController.text}');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                  ),
                  child: const Text('Sign Up',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 80),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                      text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                        color: Colors.deepPurple.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()), // Adjust to your login screen
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                      child: Text(
                        'Back to Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
