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
}
