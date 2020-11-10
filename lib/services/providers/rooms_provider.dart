import 'package:cleaner_app/consts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class RoomsProvider extends ChangeNotifier {
  List<Room> _rooms = [];
  String _cleanerId;
  String _hospitalId, _floor, _building;

  List<Room> get rooms {
    List<Room> filteredRooms = [];
    filteredRooms = _hospitalId == null
        ? _rooms
        : _rooms.where((room) => room.hospital == _hospitalId).toList();
    filteredRooms = _building == null
        ? filteredRooms
        : filteredRooms.where((room) => room.building == _building).toList();
    filteredRooms = _floor == null
        ? filteredRooms
        : filteredRooms.where((room) => room.floor == _floor).toList();
    return filteredRooms;
  }

  void resetFilter() {
    _hospitalId = null;
    _floor = null;
    _building = null;
  }

  void filterHospital(String hospitalId) {
    _hospitalId = hospitalId;
    notifyListeners();
  }

  void filterBuilding(String building) {
    _building = building == 'All' ? null : building;
    notifyListeners();
  }

  void filterFloor(String floor) {
    _floor = floor == 'All' ? null : floor;
    notifyListeners();
  }

  void updateCleanerId(String cleanerId) {
    _cleanerId = cleanerId;
  }

  Future<List<Room>> fetchAssignedRooms() async {
    final Dio dio = new Dio();
    final List<Room> roomList = [];
    final endPointUrl = '/api/cleaners/rooms';
    try {
      final response = await dio.get(
        Consts.baseUrl + endPointUrl,
        queryParameters: {'cleaner_id': _cleanerId},
        options: Options(headers: {'Authorization': Consts.apiKey}),
      );
      final responseJson = response.data as List<dynamic>;
      responseJson.forEach((room) {
        roomList.add(Room.fromJson(room));
      });
      _rooms = roomList;
      notifyListeners();
      return _rooms;
    } catch (error) {
      throw (error);
    }
  }
}
