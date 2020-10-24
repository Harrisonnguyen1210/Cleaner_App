import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';

class RoomInfoTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Consts.primaryBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info,
            color: Consts.white,
            size: 40,
          ),
          SizedBox(width: 8),
          Text(
            'Info',
            style: TextStyle(
              color: Consts.white,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}
