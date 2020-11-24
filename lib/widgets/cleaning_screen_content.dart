import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/helpers/custom_dialog.dart';
import 'package:cleaner_app/helpers/error_dialog.dart';
import 'package:cleaner_app/models/models.dart';
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
  double _sliderValue = 1.0;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    final singleRoomProvider =
        Provider.of<SingleRoomProvider>(context, listen: false);
    singleRoomProvider.fetchContaminationMap().then((_) {
      singleRoomProvider.fetchActivityGraph();
      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      ErrorDialog.showErrorDialog(context, error.toString());
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _onCleaningButtonClicked() {
    final singleRoomProvider =
        Provider.of<SingleRoomProvider>(context, listen: false);
    CustomDialog.showCustomDialog(
      context,
      'Do you want to ${singleRoomProvider.isCleaning ? 'stop' : 'start'} cleaning?',
      () => singleRoomProvider.isCleaning
          ? singleRoomProvider
              .stopCleaning()
              .then((_) => _navigateToReportScreen(singleRoomProvider.room))
          : singleRoomProvider.startCleaning(),
    );
  }

  void _navigateToReportScreen(Room room) {
    final drawerStateProvider = Provider.of<DrawerStateProvider>(
      context,
      listen: false,
    );
    drawerStateProvider.setCurrentDrawer(2);
    Consts.navigatorKey.currentState.pushNamedAndRemoveUntil(
      RouteNames.report,
      (_) => false,
      arguments: room,
    );
  }

  void sliderOnChanged(value) {
    final singleRoomProvider =
        Provider.of<SingleRoomProvider>(context, listen: false);
    singleRoomProvider.updateScaling(value);
    setState(() {
      _sliderValue = value;
    });
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
                      ContaminationMap(
                        imageData: singleRoomProvider.imageData,
                        imageCleaningData: singleRoomProvider.imageCleaningData,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Activity graph:',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(child: ActivityGraph()),
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
                    SizedBox(height: 25),
                    Text(
                      'Map scaling:',
                      style: TextStyle(
                        color: Consts.primaryBlue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      activeColor: Consts.primaryBlue,
                      value: _sliderValue,
                      onChanged: (value) => sliderOnChanged(value),
                      min: 1,
                      max: 100,
                    ),
                    SizedBox(height: 60),
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
                      onPress: _onCleaningButtonClicked,
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
