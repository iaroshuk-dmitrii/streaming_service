import 'package:flutter/material.dart';
import 'package:streaming_service/ui/screens/artists_screen.dart';
import 'package:streaming_service/ui/screens/collection_screen.dart';
import 'package:streaming_service/ui/screens/search_screen.dart';

class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({Key? key}) : super(key: key);

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _currentTab = 0;

  void _onSwitchTab(int index) {
    if (_currentTab != index) {
      setState(() {
        {
          _currentTab = index;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTab,
        children: const [
          ArtistsScreen(),
          SearchScreen(),
          CollectionScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
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
        onTap: (index) {
          _onSwitchTab(index);
        },
      ),
    );
  }
}
