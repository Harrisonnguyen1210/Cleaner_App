import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/helpers/error_dialog.dart';
import 'package:dio/dio.dart';
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
              } on DioError catch (_) {
                ErrorDialog.showErrorDialog(context);
              } catch (error) {
                ErrorDialog.showErrorDialog(
                  Consts.cleaningScreenKey.currentContext,
                  errorContent: error.response.data['error'],
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
