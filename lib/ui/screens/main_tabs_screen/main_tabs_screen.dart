import 'package:flutter/material.dart';
import 'package:streaming_service/ui/screens/artists_screen/top_artists_screen.dart';
import 'package:streaming_service/ui/screens/artists_screen/top_artists_screen_model.dart';
import 'package:streaming_service/ui/screens/collection_screen.dart';
import 'package:streaming_service/ui/screens/main_tabs_screen/main_tabs_screen_model.dart';
import 'package:streaming_service/ui/screens/search_screen/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/ui/screens/search_screen/search_screen_model.dart';

class MainTabsScreen extends StatelessWidget {
  const MainTabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainTabsScreenModel>();
    return Scaffold(
      body: IndexedStack(
        index: model.currentTab,
        children: [
          ChangeNotifierProvider(
            create: (_) => TopArtistsScreenModel()..getArtistList(),
            child: const ArtistsScreen(),
          ),
          ChangeNotifierProvider(
            create: (_) => SearchScreenModel(),
            child: const SearchScreen(),
          ),
          const CollectionScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: model.currentTab,
        items: const [
          BottomNavigationBarItem(
            label: "Исполнители",
            icon: Icon(Icons.library_music),
            tooltip: "Исполнители",
          ),
          BottomNavigationBarItem(
            label: "Поиск",
            icon: Icon(Icons.search),
            tooltip: "Поиск",
          ),
          BottomNavigationBarItem(
            label: "Коллекция",
            icon: Icon(Icons.favorite),
            tooltip: "Коллекция",
          ),
        ],
        onTap: (index) => model.switchTab(index),
      ),
    );
  }
}
