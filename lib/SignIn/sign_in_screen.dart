import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Profile/PrivacyPolicy/privacy_policy_screen.dart';
import '../Profile/TermsOfService/terms_of_service_screen.dart';
// import '../Services/global_variables.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
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
    // String iconURL = loginWallpaperSummerFirebase;

    return Scaffold(
        appBar: AppBar(title: const Text("Sign In")),
        body: Stack(
          children: [
            // CachedNetworkImage(
            //   imageUrl: iconURL,
            //   errorWidget: (context, url, error) => Icon(Icons.error),
            //   width: double.infinity,
            //   height: double.infinity,
            //   fit: BoxFit.cover,
            //   alignment: FractionalOffset(_animation.value, 0),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 300, horizontal: 0),
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                      children: [
                        Center(
                          child: ElevatedButton.icon(
                            icon: Image.asset(
                              'assets/images/google_logo.png',
                              height: 30.0,
                              width: 30.0,
                            ),
                            label: Text(
                              'Sign in with Google into your college email',
                              textAlign: TextAlign.center,
                            ),
                            onPressed: _signInWithGoogle,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(250, 50),
                              padding: EdgeInsets.all(20.0),
                              backgroundColor: Colors.white,
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.deepOrange.shade300,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(text: 'By continuing you agree to our '),
                              TextSpan(
                                text: 'terms of service',
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TermsOfServiceScreen()),
                                    );
                                  },
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'privacy policy',
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PrivacyPolicyScreen()),
                                    );
                                  },
                              ),
                              TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ));
  }
}
