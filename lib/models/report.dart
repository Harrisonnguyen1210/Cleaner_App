import 'package:flutter/foundation.dart';

class Report {
  final String id;
  final String cleanerId;
  final String name;
  final DateTime cleaningTime;
  final String comments;

  Report({
    @required this.id,
    @required this.cleanerId,
    @required this.name,
    @required this.cleaningTime,
    @required this.comments,
  });
}
