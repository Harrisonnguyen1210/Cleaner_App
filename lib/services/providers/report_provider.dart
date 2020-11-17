import 'dart:convert';
import 'dart:io';

import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/models/models.dart';
import 'package:dio/dio.dart';

class ReportProvider {
  Future<void> submitCleaningReport(Report reportedRoom) async {
    final Dio dio = new Dio();
    final endPointUrl = '/api/report';
    try {
      await dio.post(
        Consts.baseUrl + endPointUrl,
        options: Options(headers: {'Authorization': Consts.apiKey}),
        data: json.encode({
          'room_id': reportedRoom.roomId,
          'cleaner_id': reportedRoom.cleanerId,
          'comments': reportedRoom.comments,
          'overview': reportedRoom.overview,
          'cleaning_succesful': reportedRoom.cleanSuccessful,
        }),
      );
    } catch (error) {
      if (error.error is SocketException) throw Exception(Consts.internetError);
      throw Exception(Consts.reportError);
    }
  }
}
