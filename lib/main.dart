import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_fundamental_submission/screen/main_screen.dart';
import 'package:new_fundamental_submission/data/api/api.dart';
import 'package:new_fundamental_submission/provider/detail/bookmark_icon_provider.dart';
import 'package:new_fundamental_submission/provider/detail/bookmark_list_provider.dart';
import 'package:new_fundamental_submission/provider/detail/restaurant_detail_provider.dart';
import 'package:new_fundamental_submission/provider/detail/restaurant_review_provider.dart';
import 'package:new_fundamental_submission/provider/home/category_list_provider.dart';
import 'package:new_fundamental_submission/provider/home/restaurant_list_provider.dart';
import 'package:new_fundamental_submission/provider/main/index_nav_provider.dart';
import 'package:new_fundamental_submission/provider/main/theme_provider.dart';
import 'package:new_fundamental_submission/provider/search/search_restaurant_list_provider.dart';
import 'package:new_fundamental_submission/screen/detail_screen.dart';
import 'package:new_fundamental_submission/static/navigation/navigation_route.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => BookmarkIconProvider()),
        ChangeNotifierProvider(create: (context) => BookmarkListProvider()),
        Provider(create: (context) => Api()),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(context.read<Api>()),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryListProvider(context.read<Api>()),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(context.read<Api>()),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantReviewProvider(context.read<Api>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              SearchRestaurantListProvider(context.read<Api>()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      initialRoute: NavigationRoute.main.name,
      routes: {
        NavigationRoute.main.name: (context) => const MainScreen(),
        NavigationRoute.detail.name: (context) => DetailScreen(
          restaurantId: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}
