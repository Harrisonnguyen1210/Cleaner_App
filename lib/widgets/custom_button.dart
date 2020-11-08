import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onPress;

  const CustomButton({
    Key key,
    @required this.title,
    @required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 60,
      minWidth: 150,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Consts.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        color: Consts.primaryBlue,
        onPressed: onPress,
      ),
    );
  }
}
