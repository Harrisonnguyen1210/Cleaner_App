import 'package:flutter/foundation.dart';

class Hospital {
  final String id;
  final String name;

  Hospital({
    @required this.id,
    @required this.name,
  });

  factory Hospital.fromJson(dynamic hospital) {
    return Hospital(id: hospital['_id'], name: hospital['name']);
  }
}
