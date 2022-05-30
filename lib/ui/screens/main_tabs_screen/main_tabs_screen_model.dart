import 'package:flutter/material.dart';

class MainTabsScreenModel extends ChangeNotifier {
  var _currentTab = 0;

  int get currentTab => _currentTab;
  void switchTab(int value) {
    _currentTab = value;
    notifyListeners();
  }
}
