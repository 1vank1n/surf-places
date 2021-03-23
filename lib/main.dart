import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surf Places',
      theme: lightThemeData,
      // theme: darkThemeData,
      // home: VisitingScreen(),
      home: SightListScreen(),
      // home: SightDetailsScreen(),
    );
  }
}
