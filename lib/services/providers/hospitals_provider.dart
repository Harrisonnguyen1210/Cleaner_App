import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HospitalsProvider extends ChangeNotifier {
  List<Hospital> _hospitals = [];

  List<Hospital> get hospitals {
    return _hospitals;
  }

  Future<void> fetchHospitals() async {
    final Dio dio = new Dio();
    final List<Hospital> hospitalList = [];
    final endPointUrl = '/api/hospitals/';
    try {
      final response = await dio.get(
        Consts.baseUrl + endPointUrl,
        options: Options(headers: {'Authorization': Consts.apiKey}),
      );
      final responseJson = response.data as List<dynamic>;
      responseJson.forEach((hospital) {
        hospitalList.add(Hospital.fromJson(hospital));
      });
      _hospitals = hospitalList;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
