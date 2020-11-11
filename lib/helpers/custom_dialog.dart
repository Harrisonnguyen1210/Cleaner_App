import 'package:flutter/material.dart';

class CustomDialog {
  static void showCustomDialog(
    BuildContext context,
    String dialogContent,
    Function acceptFunction,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Please confirm'),
        content: Text(dialogContent),
        actions: <Widget>[
          FlatButton(
            onPressed: acceptFunction,
            child: Text('Okay'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          )
        ],
      ),
    );
  }
}
