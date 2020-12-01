import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';

class CustomAppBar {
  static getAppBar(Widget title, BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: title,
      backgroundColor: Consts.blackLight,
      toolbarHeight: MediaQuery.of(context).size.height * 0.08,
    );
  }
}
