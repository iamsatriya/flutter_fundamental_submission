import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/screen/home_screen.dart';
import 'package:new_fundamental_submission/screen/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:new_fundamental_submission/provider/main/index_nav_provider.dart';
import 'package:new_fundamental_submission/screen/favorite_screen.dart';
import 'package:new_fundamental_submission/screen/search_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (value) {
          context.read<IndexNavProvider>().setIndexBottomNavBar = value;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            tooltip: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
            tooltip: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
            tooltip: 'Setting',
          ),
        ],
      ),
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const HomeScreen(),
            1 => const SearchScreen(),
            2 => const FavoriteScreen(),
            3 => const SettingScreen(),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
