import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cleaner_app/models/room.dart';
import 'package:http/http.dart' as http;

final endpoint = 'https://cleaner-app-api.azurewebsites.net/api/hospital0/';
final auth = 'zL43mXgXk5xa7YFRBVZscbLnGFaqVh24q5G6fhGjmAv532FAVBRtnuCJpwXWXnhw';

Future<List<Room>> fetchRooms() async {
  final response = await getOp('rooms');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> body = jsonDecode(response.body);
    List<Room> rooms = body
        .map(
          (dynamic item) => Room.fromJson(item),
        )
        .toList();
    return rooms;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load rooms');
  }
}

Future<http.Response> getOp(String url) {
  return http.get(
    endpoint + url,
    headers: {HttpHeaders.authorizationHeader: auth},
  );
}