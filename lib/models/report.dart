import 'package:flutter/foundation.dart';

class Report {
  final String roomId;
  final String cleanerId;
  final String comments;
  final String overview;
  final bool cleanSuccessful;

  Report({
    @required this.roomId,
    @required this.cleanerId,
    @required this.comments,
    @required this.overview,
    @required this.cleanSuccessful,
  });
}
