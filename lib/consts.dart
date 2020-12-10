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
  static const String pleaseFinishCleaning =
      'Please finish your cleaning event';
  static const String pleaseFinishReport = 'Please finish your cleaning report';

  //about screen text
  static const aboutTextFirstPart = """
The LeViteZer hospital room cleaning optimization solution aims to reduce hospital infection risk by optimizing the hospital room cleaning. The contamination of the rooms is tracked real time and the cleaning prioritized based on need.
 
Realtime data of space usage is visualized in the Cleaner application. On top of a room layout the most used areas are visualized to provide the cleaner with simple and intuitive information on areas that  need the most attention. The application also track the cleaning event to make sure all areas has been cleaned and then automatically generate a report with minimal interaction by cleaner. The guiding line on the design has been to keep it simple, provide only useful information and assist on making the cleaning report.
 
The Management application supports efficient resource management and planning in case of changes in staffing or reallocation of time and resources. Furthermore, It displays data from the hospital in real time and offers tools to verify & track cleaning efficiency. The application also presents detailed information about rooms and their generated cleaning reports.
 
Spotless is working name for the applications. The status of the applications is for demonstration purpose and for this purpose there is also a simple hospital contamination simulator as we currently only have  few locations equipped with the sensors. LeViteZer supports the use of the demonstrator. Comments and improvement proposals are most welcome """;
  static const aboutTextSecondPart = """


The Spotless management and cleaners applications have been developed in Metropolia University of Applied Sciences, innovation project supervised and supported by LeViteZer and in co-operation with Sodexo.""";

  static const kimEmail = '(kim.janson@levitezer.com)';

  //navigator key
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  //cleaning screen key
  static GlobalKey cleaningScreenKey = GlobalKey();
}
