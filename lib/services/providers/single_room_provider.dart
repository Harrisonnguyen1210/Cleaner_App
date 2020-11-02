import 'dart:convert';
import 'dart:typed_data';

import 'package:bitmap/bitmap.dart';
import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SingleRoomProvider extends ChangeNotifier {
  final Room room;

  SingleRoomProvider(this.room);

  Uint8List image;

  Future<void> fetchContaminationMap() async {
    final Dio dio = new Dio();
    final endPointUrl = '/api/room/heatmap';
    try {
      final response = await dio.get(
        Consts.baseUrl + endPointUrl,
        queryParameters: {
          '_id': '5f6c5a7e8934b52296b957c5',
          'type': 'contamination'
        },
        options: Options(
            headers: {'Authorization': Consts.apiKey},
            contentType: 'application/octet-stream'),
      );
      final responseJson = response.data as String;
      Uint8List imageData = utf8.encode(responseJson);
      Bitmap bitmap = Bitmap.fromHeadless(72, (imageData.length/8/72).round(), imageData);
      image = bitmap.buildHeaded();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
