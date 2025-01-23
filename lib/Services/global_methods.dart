import 'package:flutter/material.dart';

class GlobalMethods {
  static void showErrorDialog(
      {required String error, required BuildContext ctx}) {
    if (error.contains('firebase')){
      error = 'Invalid email address or password';
    }
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
              title: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.grey,
                  size: 35,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'An error occurred'
                ),
              ),
            ],
          ),
            content: Text(
              error,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto'
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: Text(
                      'OK',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto'
                    ),
                  )
              )
            ],
          );
        });
  }

  static bool containsSpecialCharacter(String input) {
    final specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharacterRegex.hasMatch(input);
  }

  static bool containsDigit(String input) {
    final digitRegex = RegExp(r'\d');
    return digitRegex.hasMatch(input);
  }

  static Widget signUpHeaderText(String message) {
    return Text(
      message,
      style: const TextStyle(
        fontFamily:  'Roboto',
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black87, // Slightly muted black for better readability
      ),
      textAlign: TextAlign.center,
    );
  }
}
