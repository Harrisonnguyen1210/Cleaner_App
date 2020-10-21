import 'dart:async';
import 'dart:io';

import 'package:cleaner_app/models/room.dart';
import 'package:http/http.dart' as http;

final endpoint = 'https://cleaner-app-api.azurewebsites.net/api';
final auth = 'zL43mXgXk5xa7YFRBVZscbLnGFaqVh24q5G6fhGjmAv532FAVBRtnuCJpwXWXnhw';

Future<List<Room>> fetchRooms() async {
  // final response = await getOp('/cleaners/rooms?cleaner_id=5f6466236654687b489334d3');
  // if (response.statusCode == 200) {
  //   List<dynamic> body = jsonDecode(response.body);
  //   List<Room> rooms = body
  //       .map(
  //         (dynamic item) => Room.fromJson(item),
  //       )
  //       .toList();
  //   return rooms;
  // } else {
  //   throw Exception('Failed to load rooms');
  // }
}

Future<http.Response> getOp(String url) {
  return http.get(
    endpoint + url,
    headers: {HttpHeaders.authorizationHeader: auth},
  );
}