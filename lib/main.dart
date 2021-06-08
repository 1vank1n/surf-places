import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/network/api.dart';
import 'package:places/data/redux/place_create/state.dart';
import 'package:places/data/redux/place_detail/middlewares.dart';
import 'package:places/data/redux/place_detail/state.dart';
import 'package:places/data/redux/place_list/middlewares.dart';
import 'package:places/data/redux/place_list/state.dart';
import 'package:places/data/redux/place_search/middlewares.dart';
import 'package:places/data/redux/place_search/state.dart';
import 'package:places/data/redux/reducer.dart';
import 'package:places/data/redux/settings/state.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/data/repository/place_respository.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/place_create_screen.dart';
import 'package:places/ui/screen/place_list_screen.dart';
import 'package:places/ui/screen/place_navigation_screen.dart';
import 'package:places/ui/screen/place_search_screen.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:redux/redux.dart';

import 'data/network/api.dart';
import 'data/redux/place_create/middlewares.dart';

void main() {
  Api api = ApiDio();
  PlaceRepository placeRepository = PlaceRepository(api: api);

  Store<AppState> store = Store(
    appReducer,
    initialState: AppState(
      placeSearchState: PlaceSearchState.initial(),
      placeListState: PlaceListState.initial(),
      placeDetailState: PlaceDetailState.initial(),
      placeCreateState: PlaceCreateState.initial(),
      settingsState: SettingsState.initial(),
    ),
    middleware: [
      PlaceSearchMiddleware(placeRepository: placeRepository),
      PlaceListMiddleware(placeRepository: placeRepository),
      PlaceDetailMiddleware(placeRepository: placeRepository),
      PlaceCreateMiddleware(placeRepository: placeRepository),
    ],
  );

  runApp(
    StoreProvider<AppState>(
      store: store,
      child: App(),
    ),
  );
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
    return StoreConnector<AppState, SettingsState>(
      converter: (Store<AppState> store) => store.state.settingsState,
      builder: (BuildContext context, SettingsState state) {
        return MaterialApp(
          title: 'Surf Places',
          theme: state.isDark ? darkThemeData : lightThemeData,
          initialRoute: AppRouter.splash,
          routes: AppRouter.routes,
        );
      },
    );
  }
}
