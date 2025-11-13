import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/screen/home_screen.dart';
import 'package:new_fundamental_submission/screen/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:new_fundamental_submission/provider/main/index_nav_provider.dart';
import 'package:new_fundamental_submission/screen/favorite_screen.dart';

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
            icon: Icon(Icons.search),
            label: 'Explore',
            tooltip: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
            tooltip: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
            tooltip: 'Profile',
          ),
        ],
      ),
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const HomeScreen(),
            1 => const FavoriteScreen(),
            2 => const ProfileScreen(),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
