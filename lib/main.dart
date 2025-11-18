import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/provider/main/local_notification_provider.dart';
import 'package:new_fundamental_submission/provider/main/user_provider.dart';
import 'package:new_fundamental_submission/screen/search_screen.dart';
import 'package:new_fundamental_submission/service/local_notification_service.dart';
import 'package:new_fundamental_submission/service/user_shared_preferences_service.dart';
import 'package:new_fundamental_submission/service/workmanager_service.dart';
import 'package:new_fundamental_submission/static/state/switch_state.dart';
import 'package:new_fundamental_submission/style/theme.dart';
import 'package:provider/provider.dart';
import 'package:new_fundamental_submission/provider/main/local_database_provider.dart';
import 'package:new_fundamental_submission/provider/setting/setting_state_provider.dart';
import 'package:new_fundamental_submission/provider/setting/shared_preferences_provider.dart';
import 'package:new_fundamental_submission/service/shared_preferences_service.dart';
import 'package:new_fundamental_submission/service/sqlite_service.dart';
import 'package:new_fundamental_submission/screen/main_screen.dart';
import 'package:new_fundamental_submission/data/api/api.dart';
import 'package:new_fundamental_submission/provider/detail/bookmark_icon_provider.dart';
import 'package:new_fundamental_submission/provider/detail/restaurant_detail_provider.dart';
import 'package:new_fundamental_submission/provider/detail/restaurant_review_provider.dart';
import 'package:new_fundamental_submission/provider/home/category_list_provider.dart';
import 'package:new_fundamental_submission/provider/home/restaurant_list_provider.dart';
import 'package:new_fundamental_submission/provider/main/index_nav_provider.dart';
import 'package:new_fundamental_submission/provider/search/search_restaurant_list_provider.dart';
import 'package:new_fundamental_submission/screen/detail_screen.dart';
import 'package:new_fundamental_submission/static/navigation/navigation_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        Provider(create: (context) => SharedPreferencesService(prefs)),
        Provider(create: (context) => UserSharedPreferencesService(prefs)),
        ChangeNotifierProvider(
          create: (context) =>
              UserProvider(context.read<UserSharedPreferencesService>()),
        ),
        Provider(
          create: (context) => LocalNotificationService()
            ..init()
            ..configureLocalTimeZone(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermissions(),
        ),
        ChangeNotifierProvider(create: (context) => SettingStateProvider()),
        ChangeNotifierProvider(
          create: (context) => SharedPreferencesProvider(
            context.read<SharedPreferencesService>(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => BookmarkIconProvider()),
        Provider(create: (context) => SqliteService()),
        ChangeNotifierProvider(
          create: (context) =>
              LocalDatabaseProvider(context.read<SqliteService>()),
        ),
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
        Provider(create: (context) => WorkmanagerService()..init()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    final sharedPreferencesProvider = context.read<SharedPreferencesProvider>();
    final settingStateProvider = context.read<SettingStateProvider>();
    final localNotificationProvider = context.read<LocalNotificationProvider>();
    Future.microtask(() async {
      if (!mounted) return;
      await localNotificationProvider.requestPermissions();
      sharedPreferencesProvider.getSettingValue();
      if (sharedPreferencesProvider.setting?.darkmode != null) {
        settingStateProvider.themeState =
            sharedPreferencesProvider.setting!.darkmode.isEnable;
      }
      if (sharedPreferencesProvider.setting?.scheduledNotification != null) {
        settingStateProvider.scheduledNotificationState =
            sharedPreferencesProvider.setting!.scheduledNotification.isEnable;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      initialRoute: NavigationRoute.main.name,
      theme: appLightTheme,
      darkTheme: appDarkTheme,
      themeMode:
          context.watch<SharedPreferencesProvider>().setting?.darkmode ?? false
          ? ThemeMode.dark
          : ThemeMode.light,
      routes: {
        NavigationRoute.main.name: (context) => const MainScreen(),
        NavigationRoute.detail.name: (context) => DetailScreen(
          restaurantId: ModalRoute.of(context)?.settings.arguments as String,
        ),
        NavigationRoute.search.name: (context) => SearchScreen(
          query: ModalRoute.of(context)?.settings.arguments as String?,
        ),
      },
    );
  }
}
