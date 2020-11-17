import 'package:flutter/material.dart';

class ErrorDialog {
  static void showErrorDialog(BuildContext context, String errorContent) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('An error occurred'),
        content: Text(errorContent),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          )
        ],
      ),
    );
  }
}
