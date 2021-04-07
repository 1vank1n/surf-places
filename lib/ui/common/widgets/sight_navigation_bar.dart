import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/icons.dart';

class SightNavigationBar extends StatefulWidget {
  @override
  _SightNavigationBarState createState() => _SightNavigationBarState();
}

class _SightNavigationBarState extends State<SightNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
