import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io' show Platform;

import '../Services/global_variables.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late Animation<double> _animation;
  late AnimationController _animationController;

  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() {
          _isLoading = false;
        });
        return; // The user canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        if (user.email != null && user.email!.endsWith('@amherst.edu')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signed in as ${user.email}')),
          );
          // Navigate to the next screen or perform other actions
        } else {
          await user.delete();
          await _auth.signOut();
          _googleSignIn.signOut();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Please use your Amherst College email address')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in with Google: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
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

  @override
  Widget build(BuildContext context) {
    String iconURL = loginWallpaperSummerFirebase;

    return Scaffold(
        appBar: AppBar(title: const Text("Sign In")),
        body: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: iconURL,
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              alignment: FractionalOffset(_animation.value, 0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 300, horizontal: 40),
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                      children: [
                        ElevatedButton.icon(
                          icon: Image.asset(
                            'assets/images/google_logo.png', // Ensure you have the Google logo in your assets
                            height: 24.0,
                            width: 24.0,
                          ),
                          label: Text(
                            'Sign in with Google\n(Use your Amherst College email address)',
                            textAlign: TextAlign.center,
                          ),
                          onPressed: _signInWithGoogle,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            minimumSize: Size(250, 50),
                            padding: EdgeInsets.all(10.0),
                            textStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        )
    );
  }
}
