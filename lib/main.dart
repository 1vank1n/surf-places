import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/place_search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/network/api_dio.dart';
import 'package:places/data/repository/place_respository.dart';
import 'package:places/ui/screen/place_create_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/place_list_screen.dart';
import 'package:places/ui/screen/place_navigation_screen.dart';
import 'package:places/ui/screen/place_search_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:provider/provider.dart';

import 'data/network/api.dart';

void main() {
  Api api = ApiDio();
  PlaceRepository placeRepository = PlaceRepository(api: api);
  PlaceInteractor placeInteractor = PlaceInteractor(placeRepository: placeRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppModel>(create: (_) => AppModel()),
        Provider<PlaceInteractor>(create: (_) => placeInteractor),
        Provider<PlaceSearchInteractor>(create: (_) => PlaceSearchInteractor()),
        Provider<SettingsInteractor>(create: (_) => SettingsInteractor()),
      ],
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
  static const String navigation = '/navigation';
  static const String placeList = '/places';
  static const String placeDetail = '/places/detail';
  static const String placeSearch = '/places/search';
  static const String placeFilter = '/places/filter';
  static const String placeCreate = '/places/create';
  static const String placeVisiting = '/places/visiting';
  static const String settings = '/settings';

  static final Map<String, Widget Function(BuildContext)> routes = {
    AppRouter.splash: (data) => SplashScreen(),
    AppRouter.onboarding: (data) => OnboardingScreen(),
    AppRouter.navigation: (data) => PlaceNavigationScreen(),
    AppRouter.placeList: (data) => PlaceListScreen(),
    AppRouter.placeSearch: (data) => PlaceSearchScreen(),
    AppRouter.placeFilter: (data) => FiltersScreen(),
    AppRouter.placeCreate: (data) => PlaceCreateScreen(),
    AppRouter.placeVisiting: (data) => VisitingScreen(),
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
