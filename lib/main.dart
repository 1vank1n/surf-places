import 'package:flutter/material.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (BuildContext context) => AppModel(), child: App()));
}

class AppModel extends ChangeNotifier {
  ThemeData theme = lightThemeData;

  void toggleTheme() {
    theme = (theme == lightThemeData) ? darkThemeData : lightThemeData;
    notifyListeners();
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surf Places',
      theme: Provider.of<AppModel>(context).theme,
      // theme: darkThemeData,
      // home: VisitingScreen(),
      // home: SightListScreen(),
      // home: SightDetailsScreen(),
      // home: FiltersScreen(),
      // home: SettingsScreen(),
      // home: AddSightScreen(),
      home: OnboardingScreen(),
    );
  }
}
