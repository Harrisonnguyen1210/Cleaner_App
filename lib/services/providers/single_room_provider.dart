import 'dart:math';
import 'dart:typed_data';

import 'package:bitmap/bitmap.dart';
import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SingleRoomProvider extends ChangeNotifier {
  final Room room;

  SingleRoomProvider(this.room);

  Uint8List _imageData;

  Uint8List get imageData {
    return _imageData;
  }

  Future<void> fetchContaminationMap() async {
    final Dio dio = new Dio();
    final endPointUrl = '/api/room/heatmap';
    final List<Uint8List> colorMap = initColorMaps();
    try {
      final response = await dio.get(
        Consts.baseUrl + endPointUrl,
        queryParameters: {
          '_id': '5f6c5a7e8934b52296b957c5',
          'type': 'contamination'
        },
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Authorization': Consts.apiKey},
          contentType: 'application/octet-stream',
        ),
      );
      Uint64List imageDataInUint64 = response.data.buffer.asUint64List();
      final imageDataInUint8 = convert64to8(imageDataInUint64);
      var imgArr = Uint8List(17280);
      if (imageDataInUint8 != null && imageDataInUint8.isNotEmpty) {
        var byteIdx = 0;
        for (var imgIdx = 0; imgIdx < imgArr.length; imgIdx += 4) {
          var grayValue = imageDataInUint8[byteIdx];
          imgArr[imgIdx] = colorMap[0][grayValue]; // R value
          imgArr[imgIdx + 1] = colorMap[1][grayValue]; // G value
          imgArr[imgIdx + 2] = colorMap[2][grayValue]; // B value
          imgArr[imgIdx + 3] = 255; // Alpha value
          byteIdx++;
        }
      }
      Bitmap bitmap =
          Bitmap.fromHeadless(72, (imgArr.length / 8 / 72).round(), imgArr);
      _imageData = bitmap.buildHeaded();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Uint8ClampedList convert64to8(Uint64List array) {
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
    max = maxRaw / 30;
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

  List<Uint8List> initColorMaps() {
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
}
