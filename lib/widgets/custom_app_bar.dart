import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';

class CustomAppBar {
  static getAppBar(Widget title) {
    return AppBar(
      centerTitle: false,
      title: title,
      backgroundColor: Consts.blackLight,
      toolbarHeight: 80,
    );
  }
}
