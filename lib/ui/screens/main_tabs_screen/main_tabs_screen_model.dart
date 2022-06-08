import 'package:flutter/material.dart';

class MainTabsScreenModel extends ChangeNotifier {
  var _currentTab = 0;
  bool _disposed = false;

  int get currentTab => _currentTab;
  void switchTab(int value) {
    _currentTab = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
