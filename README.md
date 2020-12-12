# Spotless

A Flutter application built for hospital cleaners to have a quick access to assigned rooms, ability to start/stop cleaning events and useful UI to sunmit cleaning report. This application is mainly built in Flutter (with Dart as a programming language) and it communicates with Azure database api for updating cleaning activities.

## Packages used

- provider: state management
- dio: http client for dart
- bitmap: manipulate image on Flutter apps (contamination map)
- flutter_spinkit: a collection of loading indicators animated with flutter
- flutter_phoenix: restart application state
- intl: format datetime
- flutter_launcher_icons: update Flutter app's launcher icon.
- charts_flutter: line chart for activity graph

## Main features:
- Login/Logout cleaners
- View/Fitter assigned rooms for a specific cleaner
- Start/Stop cleaning event
- View contamination/cleaning map, room’s details, activity graph
- View profile page
- Fill cleaning event report
- View about page


## Development setup

Currently the application only support iPad tablets, so in order to install the app, Flutter needs to be installed on Mac and the application must be run on iPad simulators or iPad devices.

- Install Flutter on your local machine: https://flutter.dev/docs/get-started/install

## Application overview

Whole demo of the app can be viewed here: https://youtu.be/_UNf1WXMzp4


