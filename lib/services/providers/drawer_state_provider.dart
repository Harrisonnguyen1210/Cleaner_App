import 'package:flutter/material.dart';

class DrawerStateProvider with ChangeNotifier {
  int _selectedIndex = 0;
  bool _canBeNavigated = true;
  int get getCurrentDrawer => _selectedIndex;
  bool get canBeNavigated => _canBeNavigated;

  void setCurrentDrawer(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setCanBeNavigated(bool isEnabled) {
    _canBeNavigated = isEnabled;
  }
}
