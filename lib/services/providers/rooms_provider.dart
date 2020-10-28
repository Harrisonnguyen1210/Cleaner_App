import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class RoomsProvider extends ChangeNotifier {
  List<Room> _rooms = [];
  String cleanerId = '5f6466236654687b489334d3';

  List<Room> get rooms {
    return _rooms;
  }

  final String apiKey =
      'zL43mXgXk5xa7YFRBVZscbLnGFaqVh24q5G6fhGjmAv532FAVBRtnuCJpwXWXnhw';
  final String baseUrl = 'https://cleaner-app-api.azurewebsites.net';

  Future<void> fetchAssignedRooms() async {
    final Dio dio = new Dio();
    final List<Room> roomList = [];
    final endPointUrl = '/api/cleaners/rooms';
    try {
      final response = await dio.get(
        baseUrl + endPointUrl,
        queryParameters: {'cleaner_id': cleanerId},
        options: Options(headers: {'Authorization': apiKey}),
      );
      final responseJson = response.data as List<dynamic>;
      responseJson.forEach((room) {
        roomList.add(Room.fromJson(room));
      });
      _rooms = roomList;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
