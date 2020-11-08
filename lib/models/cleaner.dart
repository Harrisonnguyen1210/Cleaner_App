import 'package:flutter/foundation.dart';

class Cleaner {
  final String name, phoneNumber, email, address, id;

  Cleaner({
    @required this.name,
    @required this.id,
    this.phoneNumber,
    this.email,
    this.address,
  });

  factory Cleaner.fromJson(dynamic cleaner) {
    return Cleaner(id: cleaner['id'], name: cleaner['name']);
  }
}
