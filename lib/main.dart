import 'package:flutter/material.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => AppModel(),
      child: App(),
    ),
  );
}

class AppModel extends ChangeNotifier {
  ThemeData theme = lightThemeData;

  void toggleTheme() {
    theme = (theme == lightThemeData) ? darkThemeData : lightThemeData;
    notifyListeners();
  }
}

class AppRouter {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String sightList = '/sights';
  static const String sightDetail = '/sights/detail';
  static const String sightSearch = '/sights/search';
  static const String sightFilter = '/sights/filter';
  static const String sightCreate = '/sights/create';
  static const String sightVisiting = '/sights/visiting';
  static const String settings = '/settings';

  static final Map<String, Widget Function(BuildContext)> routes = {
    AppRouter.splash: (data) => SplashScreen(),
    AppRouter.onboarding: (data) => OnboardingScreen(),
    AppRouter.sightList: (data) => SightListScreen(),
    AppRouter.sightDetail: (data) => SightDetailsScreen(),
    AppRouter.sightSearch: (data) => SightSearchScreen(),
    AppRouter.sightFilter: (data) => FiltersScreen(),
    AppRouter.sightCreate: (data) => AddSightScreen(),
    AppRouter.sightVisiting: (data) => VisitingScreen(),
    AppRouter.settings: (data) => SettingsScreen(),
  };
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surf Places',
      theme: Provider.of<AppModel>(context).theme,
      initialRoute: AppRouter.splash,
      routes: AppRouter.routes,
    );
  }
}
