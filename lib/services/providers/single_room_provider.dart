import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:bitmap/bitmap.dart';
import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SingleRoomProvider extends ChangeNotifier {
  final Room room;
  Map<String, dynamic> activityGraphData;
  SingleRoomProvider(this.room);
  double _scaling = 1;
  bool _isCleaning = false;
  Uint64List _imageDataInUint64;
  Uint64List _imageCleaningDataInUint64;
  Uint8List _floorImage;

  Uint8List get imageCleaningData {
    if ((!room.hasSensor && !room.isSimulated) || _imageCleaningDataInUint64 == null) return null;
    return _buildCleaningImageData(_imageCleaningDataInUint64);
  }

  Uint8List get imageData {
    if ((!room.hasSensor && !room.isSimulated) || _imageDataInUint64 == null) return null;
    return _buildImageData(_imageDataInUint64);
  }

  Uint8List get floorImage {
    return _floorImage;
  }

  bool get isCleaning {
    return _isCleaning;
  }

  void updateScaling(double scale) {
    _scaling = scale;
    notifyListeners();
  }

  Future<void> fetchContaminationMap() async {
    if (!room.hasSensor && !room.isSimulated) return;
    final Dio dio = new Dio();
    final endPointUrl = '/api/room/heatmap';
    try {
      final response = await dio.get(
        Consts.baseUrl + endPointUrl,
        queryParameters: {'_id': room.id, 'type': 'contamination'},
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Authorization': Consts.apiKey},
          contentType: 'application/octet-stream',
        ),
      );
      _imageDataInUint64 = response.data.buffer.asUint64List();
      notifyListeners();
    } on DioError catch (error) {
      if (error.type == DioErrorType.DEFAULT && error.error is SocketException)
        throw Exception(Consts.internetError);
      else
        throw Exception(Consts.unindentifiedError);
    } catch (error) {
      throw Exception(Consts.unindentifiedError);
    }
  }

  Future<void> _fetchCleaningMap() async {
    final Dio dio = new Dio();
    final endPointUrl = '/api/room/heatmap';
    try {
      final response = await dio.get(
        Consts.baseUrl + endPointUrl,
        queryParameters: {'_id': room.id, 'type': 'clean'},
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Authorization': Consts.apiKey},
          contentType: 'application/octet-stream',
        ),
      );
      _imageCleaningDataInUint64 = response.data.buffer.asUint64List();
      notifyListeners();
    } on DioError catch (error) {
      if (error.type == DioErrorType.DEFAULT && error.error is SocketException)
        throw Exception(Consts.internetError);
      else
        throw Exception(Consts.unindentifiedError);
    } catch (error) {
      throw Exception(Consts.unindentifiedError);
    }
  }

  Future<void> startCleaning() async {
    if (!room.hasSensor && !room.isSimulated) throw Exception(Consts.noSuchSensor);
    const fetchInterval = const Duration(seconds: 3);
    final Dio dio = new Dio();
    final endPointUrl = '/api/room/startcleaning';
    try {
      await dio.get(
        Consts.baseUrl + endPointUrl,
        queryParameters: {'_id': room.id},
        options: Options(
          headers: {'Authorization': Consts.apiKey},
        ),
      );
      _isCleaning = true;
      notifyListeners();
      Timer.periodic(fetchInterval, (Timer timer) async {
        if (!isCleaning) {
          timer.cancel();
          return;
        }
        await _fetchCleaningMap();
      });
    } on DioError catch (error) {
      if (error.type == DioErrorType.DEFAULT && error.error is SocketException)
        throw Exception(Consts.internetError);
      else
        throw Exception(Consts.unindentifiedError);
    } catch (error) {
      throw Exception(Consts.unindentifiedError);
    }
  }

  Future<void> stopCleaning() async {
    if (!room.hasSensor && !room.isSimulated) throw Exception(Consts.noSuchSensor);
    final Dio dio = new Dio();
    final endPointUrl = '/api/room/stopcleaning';
    try {
      await dio.get(
        Consts.baseUrl + endPointUrl,
        queryParameters: {'_id': room.id},
        options: Options(
          headers: {'Authorization': Consts.apiKey},
        ),
      );
    } on DioError catch (error) {
      if (error.type == DioErrorType.DEFAULT && error.error is SocketException)
        throw Exception(Consts.internetError);
      else
        throw Exception(Consts.unindentifiedError);
    } catch (error) {
      throw Exception(Consts.unindentifiedError);
    }
    _isCleaning = false;
    notifyListeners();
  }

  void fetchActivityGraph() {
    if (!room.hasSensor && !room.isSimulated) throw Exception(Consts.noSuchSensor);
    if (room.activityData.isEmpty || room.lastCleaned == 'unknown') throw Exception(Consts.notEnoughData);

    // Old implementation of activity graph
    // final timeDiffer = calculateTimestampDifference(
    //     DateTime.parse(room.lastCleaned), DateTime.parse(room.lastUpdate));
    // final maxX = (timeDiffer / 20).ceil() * 20;
    // final maxY = (room.activityData.reduce(max) / 5).ceil() * 5;
    // final minY = room.activityData.reduce(min);
    // final dateFormat = room.activityData.length <= 10
    //     ? DateFormat('hh:mm')
    //     : DateFormat('dd/MM hh:mm');
    // final xTitles = [
    //   dateFormat.format(DateTime.parse(room.lastCleaned)),
    //   dateFormat.format(
    //       DateTime.parse(room.lastCleaned).add(Duration(seconds: maxX ~/ 5))),
    //   dateFormat.format(DateTime.parse(room.lastCleaned)
    //       .add(Duration(seconds: maxX ~/ 5 * 2))),
    //   dateFormat.format(DateTime.parse(room.lastCleaned)
    //       .add(Duration(seconds: maxX ~/ 5 * 3))),
    //   dateFormat.format(DateTime.parse(room.lastCleaned)
    //       .add(Duration(seconds: maxX ~/ 5 * 4))),
    //   dateFormat.format(
    //       DateTime.parse(room.lastCleaned).add(Duration(seconds: maxX))),
    // ];
    // final yTitles = [
    //   minY.toInt().toString(),
    //   (maxY / 5 * 1).toInt().toString(),
    //   (maxY / 5 * 2).toInt().toString(),
    //   (maxY / 5 * 3).toInt().toString(),
    //   (maxY / 5 * 4).toInt().toString(),
    //   maxY.toInt().toString(),
    // ];
    activityGraphData = {
      'lastCleaned': DateTime.parse(room.lastCleaned),
      // 'maxY': maxY,
      // 'minY': minY,
      // 'maxX': maxX,
      // 'minX': 0,
      // 'xTitles': xTitles,
      // 'yTitles': yTitles,
      'activityData': room.activityData,
    };
    notifyListeners();
  }

  Future<void> fetchFloorMap() async {
    if (!room.hasSensor && !room.isSimulated) return;
    final Dio dio = new Dio();
    final endPointUrl = '/api/room/floorplan';
    try {
      final response = await dio.get(
        Consts.baseUrl + endPointUrl,
        queryParameters: {'_id': room.id},
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Authorization': Consts.apiKey},
          contentType: 'image/png',
        ),
      );
      _floorImage = response.data;
      notifyListeners();
    } on DioError catch (error) {
      if (error.type == DioErrorType.DEFAULT && error.error is SocketException)
        throw Exception(Consts.internetError);
      else
        throw Exception(Consts.unindentifiedError);
    } catch (error) {
      throw Exception(Consts.unindentifiedError);
    }
  }

  // Old implementation of activity graph
  // int calculateTimestampDifference(DateTime startTime, DateTime endTime) {
  //   return endTime.difference(startTime).inSeconds;
  // }

  Uint8ClampedList _convert64to8(Uint64List array) {
    var min, max, pix;
    var minRaw = 9223372036854775807;
    var maxRaw = 0;
    for (var j = 0; j < array.length; j++) {
      pix = array[j];
      if (pix < minRaw) {
        minRaw = pix;
      }
      if (pix > maxRaw) {
        maxRaw = pix;
      }
    }
    max = maxRaw / _scaling;
    min = minRaw;
    var pix1;
    List<int> imP = [];
    if (max <= min) {
      max = min + 1;
    }
    for (var i = 0; i < array.length; i++) {
      pix1 = ((array[i] - min) * 255 / (max - min)).floor();
      if (pix1 > 255) {
        pix1 = 255;
      }
      if (pix1 < 0) {
        pix1 = 0;
      }
      imP.add(pix1);
    }
    return Uint8ClampedList.fromList(imP);
  }

  List<Uint8List> _initColorMaps() {
    List<int> tableRed = [];
    List<int> tableGreen = [];
    List<int> tableBlue = [];
    int red, green, blue;
    var a, b;
    for (var i = 0; i <= 255; i++) {
      a = i * 0.01236846501;
      b = cos(a - 1.0);
      red = (pow(2.0, sin(a - 1.6)) * 200).round();
      green = (atan(a) * b * 155 + 100.0).round();
      blue = (b * 255).round();
      red = min(255, red);
      green = min(255, green);
      blue = min(255, blue);
      red = max(0, red);
      green = max(0, green);
      blue = max(0, blue);
      tableRed.add(red);
      tableGreen.add(green);
      tableBlue.add(blue);
    }
    return [
      Uint8List.fromList(tableRed),
      Uint8List.fromList(tableGreen),
      Uint8List.fromList(tableBlue)
    ];
  }

  Uint8List _buildImageData(Uint64List imageDataInUint64) {
    final List<Uint8List> colorMap = _initColorMaps();
    final imageDataInUint8 = _convert64to8(imageDataInUint64);
    var imgArr = Uint8List(imageDataInUint8.length * 4);
    if (imageDataInUint8 != null && imageDataInUint8.isNotEmpty) {
      var byteIdx = 0;
      for (var imgIdx = 0; imgIdx < imgArr.length; imgIdx += 4) {
        var grayValue = imageDataInUint8[byteIdx];
        imgArr[imgIdx] = colorMap[0][grayValue]; // R value
        imgArr[imgIdx + 1] = colorMap[1][grayValue]; // G value
        imgArr[imgIdx + 2] = colorMap[2][grayValue]; // B value
        imgArr[imgIdx + 3] = 255;
        byteIdx++;
      }
    }
    Bitmap bitmap =
        Bitmap.fromHeadless(72, (imgArr.length / 4 / 72).round(), imgArr);
    return bitmap.buildHeaded();
  }

  Uint8List _buildCleaningImageData(Uint64List imageDataInUint64) {
    final List<Uint8List> colorMap = _initColorMaps();
    final imageDataInUint8 = _convert64to8(imageDataInUint64);
    var imgArr = Uint8List(imageDataInUint8.length * 4);
    if (imageDataInUint8 != null && imageDataInUint8.isNotEmpty) {
      var byteIdx = 0;
      for (var imgIdx = 0; imgIdx < imgArr.length; imgIdx += 4) {
        var grayValue = imageDataInUint8[byteIdx];
        imgArr[imgIdx] = colorMap[0][grayValue]; // R value
        imgArr[imgIdx + 1] = colorMap[1][grayValue]; // G value
        imgArr[imgIdx + 2] = colorMap[2][grayValue]; // B value
        if (imgArr[imgIdx] == colorMap[0][0] &&
            imgArr[imgIdx + 1] == colorMap[1][0] &&
            imgArr[imgIdx + 2] == colorMap[2][0]) {
          imgArr[imgIdx + 3] = 20; // Alpha value
        } else
          imgArr[imgIdx + 3] = 255;
        byteIdx++;
      }
    }
    Bitmap bitmap =
        Bitmap.fromHeadless(72, (imgArr.length / 4 / 72).round(), imgArr);
    return bitmap.buildHeaded();
  }
}
