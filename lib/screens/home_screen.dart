import 'package:cleaner_app/models/room.dart';
import 'package:cleaner_app/services/api.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  Future<List<Room>> futureRooms;

  @override
  void initState() {
    super.initState();
    futureRooms = fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Room>>(
            future: futureRooms,
            builder:
                (BuildContext context, AsyncSnapshot<List<Room>> snapshot) {
              if (snapshot.hasData) {
                List<Room> posts = snapshot.data;
                return ListView(
                  children: posts
                      .map(
                        (Room room) => ListTile(
                          title: Text(room.roomId),
                          subtitle: Text("${room.floorId}"),
                        ),
                      )
                      .toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
