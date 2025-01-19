import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tusk_force/ForgetPassword/forget_password_screen.dart';
import 'package:tusk_force/Services/global_methods.dart';
import 'package:tusk_force/Services/global_variables.dart';
import 'package:tusk_force/SignUpPage/signup_screen.dart';

bool containsSpecialCharacter(String input) {
  final specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  return specialCharacterRegex.hasMatch(input);
}

bool containsDigit(String input) {
  final digitRegex = RegExp(r'\d');
  return digitRegex.hasMatch(input);
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  final TextEditingController _emailTextController =
      TextEditingController(text: '');

  final TextEditingController _passTextController =
      TextEditingController(text: '');

  final FocusNode _passFocusNode = FocusNode();
  bool _isLoading = false;
  bool _obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _animationController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });

    _animationController.forward();
    super.initState();
  }

  void _submitFormOnLogin() async {
    final isValid = _loginFormKey.currentState!.validate();
    if (isValid) {
     setState(() {
       _isLoading = true;
     });
     try {
       await _auth.signInWithEmailAndPassword(
         email: _emailTextController.text.trim().toLowerCase(),
         password: _passTextController.text.trim(),
       );
       Navigator.canPop(context)? Navigator.pop(context) : null;

     } on SocketException {
       setState(() {
         _isLoading = false;
       });
       GlobalMethods.showErrorDialog(
           error: 'No internet connection', ctx: context);
     }

     on FirebaseAuthException catch (e) {
       setState(() {
         _isLoading = false;
       });

       GlobalMethods.showErrorDialog(
         error: 'Error signing you in: ${e.code}',
         ctx: context,
       );
     }
     catch (error) {
       setState(() {
         _isLoading = false;
       });
       GlobalMethods.showErrorDialog(
           error: error.toString(),
           ctx: context);
     }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String iconURL = loginWallpaperFallFirebase;

    // Conditional rendering of the loading screen based on the wallpaper

    late Color conditionalProgressBgColor;
    late String conditionalLogoPath;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (iconURL == loginWallpaperWinterFirebase) {
      conditionalProgressBgColor = Colors.lightBlue.shade100;
      conditionalLogoPath = logoCoolPath;
    } else if (iconURL == loginWallpaperSummerFirebase) {
      conditionalProgressBgColor = Colors.brown.shade100;
      conditionalLogoPath = logoWarmPath;
    } else {
      conditionalProgressBgColor = Colors.lightGreenAccent.shade100;
      conditionalLogoPath = logoWarmPath;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: iconURL,
            placeholder: (context, url) => Container(
              color: conditionalProgressBgColor,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Container(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80),
                    child: Image.asset(
                        heroIconPath,
                        width: 80,
                        height: 80,
                    )
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailTextController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !value.contains('@amherst.edu') ||
                                value.contains(' ')) {
                              return 'Please enter a valid Amherst College email address';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black, fontFamily: 'Roboto'),
                          decoration: InputDecoration(
                              hintText: 'My Amherst College Email Address',
                              hintStyle: TextStyle(color: Colors.black87, fontFamily: 'Roboto'),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue.shade400),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              )),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: _passFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passTextController,
                          obscureText: !_obscureText,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Your Password is at least six characters';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black, fontFamily: 'Roboto'),
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black87,
                                ),
                              ),
                              hintText: 'My TuskForce Password',
                              hintStyle: TextStyle(color: Colors.black87, fontFamily: 'Roboto'),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue.shade400),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPassword()));
                              },
                              child: Text(
                                'I forgot my password',
                                style: TextStyle(
                                  color: Colors.deepPurpleAccent.shade700,
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Roboto'
                                ),
                              )),
                        ),
                        SizedBox(height: 5),
                        MaterialButton(
                          onPressed: _submitFormOnLogin,
                          color: Colors.blue,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto'
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'New to TuskForce? ',
                                        style: TextStyle(
                                            color: Colors.deepPurple.shade900,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto'
                                        ),
                                      ),
                                      TextSpan(text: "       "),
                                    ]
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  style:
                                      ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepPurple
                                      ),
                                  child:  Text(
                                    "Sign Me Up !",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto'
                                    )
                                  )),
                            ],
                          )
                        )

                      ],
                    ))
              ],
            ),
          )),
        ],
      ),
    );
  }
}
