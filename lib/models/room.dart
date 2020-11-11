import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';

class Room {
  final String id,
      name,
      floor,
      building,
      hospital,
      roomType,
      patient,
      lastCleaned;
  final bool isCleaning, hasSensor;
  final num contaminationIndex;

  Room({
    @required this.id,
    @required this.name,
    @required this.floor,
    @required this.building,
    @required this.hospital,
    @required this.isCleaning,
    @required this.contaminationIndex,
    @required this.patient,
    @required this.roomType,
    @required this.lastCleaned,
    @required this.hasSensor
  });

  Color get contaminationColor {
    if (contaminationIndex <= 0.3)
      return Consts.greenIndex;
    else if (contaminationIndex > 0.3 && contaminationIndex < 0.6)
      return Consts.yellowIndex;
    else
      return Consts.redIndex;
  }

  String get patientNumber {
    if (patient == '<empty>')
      return '0';
    else
      return patient;
  }

  factory Room.fromJson(dynamic room) {
    return Room(
      hospital: room['hospital_id'],
      building: room['building'],
      floor: room['floor'],
      id: room['_id'],
      contaminationIndex: room['contamination_index'],
      isCleaning: room['false'],
      name: room['name'],
      patient: room['patient'] == '<empty>' ? '0' : room['patient'],
      lastCleaned: room['last_cleaned'] ?? 'unknown',
      roomType: room['room_type'] == '<empty>' ? 'Normal room' : room['room_type'],
      hasSensor: room['sensor_id'] != null ? true : false
    );
  }
}