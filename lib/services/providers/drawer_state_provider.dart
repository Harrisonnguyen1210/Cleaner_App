import 'package:flutter/material.dart';

class DrawerStateProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int get getCurrentDrawer => _selectedIndex;

  void setCurrentDrawer(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
