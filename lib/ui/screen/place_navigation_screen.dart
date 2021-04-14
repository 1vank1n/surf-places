import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/place_list_screen.dart';
import 'package:places/ui/screen/place_map_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

class PlaceNavigationScreen extends StatefulWidget {
  @override
  _PlaceNavigationScreenState createState() => _PlaceNavigationScreenState();
}

class _PlaceNavigationScreenState extends State<PlaceNavigationScreen> {
  final List<Widget> _screens = [
    PlaceListScreen(),
    PlaceMapScreen(),
    VisitingScreen(),
    SettingsScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 0 ? iconListFill : iconList,
              color: Theme.of(context).primaryColor,
            ),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 1 ? iconMapFill : iconMap,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 2 ? iconHeartFill : iconHeart,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 3 ? iconSettingsFill : iconSettings,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Settings',
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
