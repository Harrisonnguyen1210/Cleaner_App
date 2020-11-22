import 'package:flutter/material.dart';

class Consts {
  // color
  static const primaryBlue = Color(0xff28A9E0);
  static const secondaryBlack = Color(0xff2C353C);
  static const white = Colors.white;
  static const blackLight = Color(0xff51585E);
  static const textGrey = Color(0xff828282);
  static const grey6 = Color(0xffF2F2F2);
  static const grey4 = Color(0xffBDBDBD);
  static const greenIndex = Color(0xff28AE60);
  static const yellowIndex = Color(0xffF2C94C);
  static const redIndex = Color(0xffEB5756);
  static const activityBackground = Color(0xff232d37);

  //http request
  static const String apiKey =
      'zL43mXgXk5xa7YFRBVZscbLnGFaqVh24q5G6fhGjmAv532FAVBRtnuCJpwXWXnhw';
  static const String baseUrl = 'https://cleaner-app-api.azurewebsites.net';
  static const String internetError =
      'Please check your internet connection or try again later!';
  static const String noSuchSensor =
      'No such sensor exists or no access to cameras';
  static const String unindentifiedError =
      'There is a problem at the moment. Please try again later';
  static const String reportError =
      'Possible invalid report data. Please check room number or try again later';
  static const String notEnoughData =
      'No activity graph available. Not enough data.';

  //navigator key
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  //cleaning screen key
  static GlobalKey cleaningScreenKey = GlobalKey();
}
