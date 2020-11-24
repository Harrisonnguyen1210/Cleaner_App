import 'dart:io';

import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  List<Cleaner> _cleanerList = [];
  Cleaner _currentCleaner;

  bool _isAuth = false;

  bool get isAuth {
    return _isAuth;
  }

  Cleaner get cleaner {
    return _currentCleaner;
  }

  Future<void> _getCleanerList() async {
    final Dio dio = new Dio();
    List<Cleaner> cleanerList = [];
    final endPointUrl = '/api/cleaners';
    try {
      final response = await dio.get(
        Consts.baseUrl + endPointUrl,
        options: Options(headers: {'Authorization': Consts.apiKey}),
      );
      final responseJson = response.data as List<dynamic>;
      responseJson.forEach((cleaner) {
        cleanerList.add(Cleaner.fromJson(cleaner));
      });
      _cleanerList = cleanerList;
    } catch (error) {
      if (error.error != null) {
        if (error.error is SocketException)
          throw Exception(Consts.internetError);
      }
      throw Exception(Consts.unindentifiedError);
    }
  }

  Future<void> authenticate(String cleanerName) async {
    await _getCleanerList();
    if (_cleanerList != null) {
      _isAuth = _cleanerList.where((cleaner) {
        if (cleaner.name.toLowerCase() == cleanerName.toLowerCase()) {
          _currentCleaner = cleaner;
          return true;
        } else
          return false;
      }).isNotEmpty;
      if (!_isAuth)
        throw Exception(
          'Authentication failed, please check your user credentials',
        );
      notifyListeners();
    }
  }
}
