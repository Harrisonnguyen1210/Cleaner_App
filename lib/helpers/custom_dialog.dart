import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/helpers/error_dialog.dart';
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
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await acceptFunction();
              } catch (error) {
                ErrorDialog.showErrorDialog(
                  Consts.cleaningScreenKey.currentContext,
                  error.toString(),
                );
              }
            },
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
