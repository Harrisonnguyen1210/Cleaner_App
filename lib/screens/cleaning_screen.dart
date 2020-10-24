import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/widgets/button_cleaning.dart';
import 'package:cleaner_app/widgets/room_info_detail.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class CleaningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final Room currentRoom = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: CustomAppBar.getAppBar(Text(currentRoom.name)),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Contamination map:',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.red,
                      height: screenSize.height * 0.4,
                      width: double.infinity,
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/heatmap.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 8),
                    child: Text(
                      'Activity graph:',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //TODO: Add activity graph here
                  Expanded(
                    child: Container(
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: screenSize.width / 4.5,
            child: Column(
              children: [
                RoomInfoTitle(),
                RoomInfoDetail(
                  roomInfoTitle: 'Hospital',
                  roomInfo: currentRoom.hospital,
                  icon: Icons.local_hospital,
                ),
                RoomInfoDetail(
                  roomInfoTitle: 'Building',
                  roomInfo: currentRoom.building,
                  icon: Icons.house,
                ),
                RoomInfoDetail(
                    roomInfoTitle: 'Floor',
                    roomInfo: currentRoom.floor,
                    icon: Icons.stacked_bar_chart),
                RoomInfoDetail(
                  roomInfoTitle: 'Room Type',
                  roomInfo: currentRoom.roomType,
                  icon: Icons.category,
                ),
                RoomInfoDetail(
                  roomInfoTitle: 'Patients in room',
                  roomInfo: currentRoom.patientNumber,
                  icon: Icons.person,
                ),
                SizedBox(height: 80),
                ButtonCleaning(title: 'START CLEANING'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
