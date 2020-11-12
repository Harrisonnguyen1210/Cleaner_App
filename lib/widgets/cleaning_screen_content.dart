import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/helpers/custom_dialog.dart';
import 'package:cleaner_app/helpers/error_dialog.dart';
import 'package:cleaner_app/route_names.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:cleaner_app/widgets/contamination_map.dart';
import 'package:cleaner_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CleaningScreenContent extends StatefulWidget {
  @override
  _CleaningScreenContentState createState() => _CleaningScreenContentState();
}

class _CleaningScreenContentState extends State<CleaningScreenContent>
    with TickerProviderStateMixin {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    final singleRoomProvider =
        Provider.of<SingleRoomProvider>(context, listen: false);
    try {
      singleRoomProvider.fetchContaminationMap().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } catch (error) {
      ErrorDialog.showErrorDialog(context, errorContent: error.toString());
    }
  }

  void _onCleaningButtonClicked(
    BuildContext context,
    SingleRoomProvider singleRoomProvider,
  ) {
    CustomDialog.showCustomDialog(
      context,
      'Do you want to ${singleRoomProvider.isCleaning ? 'stop' : 'start'} cleaning?',
      () => singleRoomProvider.isCleaning
          ? singleRoomProvider.stopCleaning().then((_) => Consts
              .navigatorKey.currentState
              .pushNamedAndRemoveUntil(RouteNames.report, (_) => false))
          : singleRoomProvider.startCleaning(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final hospitalsProvider =
        Provider.of<HospitalsProvider>(context, listen: false);
    final singleRoomProvider = Provider.of<SingleRoomProvider>(context);
    final currentRoom = singleRoomProvider.room;
    final isCleaning = singleRoomProvider.isCleaning;

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Consts.primaryBlue),
            ),
          )
        : Row(
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
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ContaminationMap(),
                      Padding(
                        padding: const EdgeInsets.only(top: 32, bottom: 8),
                        child: Text(
                          'Activity graph:',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      //TODO: Add activity graph here
                      Expanded(
                        child: Container(
                          color: Colors.white,
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
                    SizedBox(height: 30),
                    RoomInfoDetail(
                      roomInfoTitle: 'Hospital',
                      roomInfo: hospitalsProvider.hospitals
                          .where(
                              (hospital) => hospital.id == currentRoom.hospital)
                          .toList()[0]
                          .name,
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
                    isCleaning
                        ? SpinKitWave(
                            size: 30.0,
                            color: Consts.primaryBlue,
                            controller: AnimationController(
                                vsync: this,
                                duration: const Duration(milliseconds: 1200)),
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: 20),
                    CustomButton(
                      title: isCleaning ? 'STOP CLEANING' : 'START CLEANING',
                      onPress: () => _onCleaningButtonClicked(
                        context,
                        singleRoomProvider,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
