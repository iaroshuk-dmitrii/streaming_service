import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/models/artist_model.dart';
import 'package:streaming_service/ui/screens/artists_about_screen/artists_about_screen.dart';
import 'package:streaming_service/ui/screens/artists_about_screen/artists_about_screen_model.dart';
import 'package:streaming_service/ui/screens/main_tabs_screen/main_tabs_screen.dart';
import 'package:streaming_service/ui/screens/main_tabs_screen/main_tabs_screen_model.dart';

abstract class Screens {
  static const mainTabs = 'MainTabsScreen';
  static const artistsAbout = 'ArtistsAboutScreen';
}

class MainNavigation {
  final initialRoute = Screens.mainTabs;

  final routes = <String, Widget Function(BuildContext)>{
    Screens.mainTabs: (context) {
      print('Create MainTabsScreen');
      return ChangeNotifierProvider(
        create: (_) => MainTabsScreenModel(),
        child: const MainTabsScreen(),
      );
    },
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Screens.artistsAbout:
        final artist = settings.arguments as ArtistModel;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => ArtistsAboutScreenModel(artist: artist)..getTrackList(),
                  child: const ArtistsAboutScreen(),
                ));
      default:
        return MaterialPageRoute(builder: (context) => const Text('Navigation Error!!'));
    }
  }
}
