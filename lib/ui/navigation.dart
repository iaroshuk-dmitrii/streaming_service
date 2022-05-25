import 'package:flutter/material.dart';
import 'package:streaming_service/ui/screens/main_tabs_screen.dart';

abstract class Screens {
  static const mainTabs = 'MainTabsScreen';
}

class MainNavigation {
  final initialRoute = Screens.mainTabs;

  final routes = <String, Widget Function(BuildContext)>{
    Screens.mainTabs: (context) {
      print('Create MainTabsScreen');
      return const MainTabsScreen();
    },
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(builder: (context) => const Text('Navigation Error!!'));
    }
  }
}
