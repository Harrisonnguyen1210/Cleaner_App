import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';

class Room {
  final String id, name, floor, building, hospitalId, roomType;
  final bool isCleaning;
  final num contaminationIndex;
  final int lastCleaned;

  Room({
    @required this.id,
    @required this.name,
    @required this.floor,
    @required this.building,
    @required this.hospitalId,
    @required this.isCleaning,
    @required this.contaminationIndex,
    this.roomType,
    this.lastCleaned,
  });

  Color get contaminationColor {
    if (contaminationIndex <= 100)
      return Consts.greenIndex;
    else if (contaminationIndex > 100 && contaminationIndex < 200)
      return Consts.yellowIndex;
    else
      return Consts.redIndex;
  }
}