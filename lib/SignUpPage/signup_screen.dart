import 'dart:io';

import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpFormKey = GlobalKey<FormState>();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          centerTitle: true,
        ),
        body: Stack(children: [
          Container(
              color: Colors.black54,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: ListView(
                  children: [
                    Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                  width: size.width * 0.4,
                                  height: size.width * 0.4,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black45,
                                      ),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: imageFile == null
                                        ? Container(
                                            color: Colors.black38,
                                            child: Icon(
                                              Icons.add_a_photo_rounded,
                                              color: Colors.deepPurple.shade900,
                                              size: size.width * 0.2,
                                            ))
                                        : Image.file(imageFile!,
                                            fit: BoxFit.fill),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ]));
  }
}
