import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';

class RoomInfoDetail extends StatelessWidget {
  final String roomInfo, roomInfoTitle;
  final IconData icon;

  const RoomInfoDetail({Key key, this.roomInfo, this.roomInfoTitle, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Consts.primaryBlue,
            size: 35,
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                roomInfoTitle,
                style: TextStyle(
                  color: Consts.primaryBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                roomInfo ?? 'Normal room',
                style: TextStyle(
                  color: Consts.textGrey,
                  fontSize: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
