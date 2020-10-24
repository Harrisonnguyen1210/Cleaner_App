import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';

class ButtonCleaning extends StatelessWidget {
  final String title;

  const ButtonCleaning({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 60,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0,
        child: Text(
          title,
          style: TextStyle(
            color: Consts.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        color: Consts.primaryBlue,
        onPressed: () {},
      ),
    );
  }
}
