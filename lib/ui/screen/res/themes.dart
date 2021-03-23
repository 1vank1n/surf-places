import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

ThemeData lightThemeData = ThemeData(
  primaryColor: primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    brightness: Brightness.light,
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: headline4,
    unselectedLabelStyle: headline4,
    labelColor: primaryTextColor,
    unselectedLabelColor: Colors.grey.shade500,
  ),
  scaffoldBackgroundColor: Colors.white,
  secondaryHeaderColor: secondaryBgColor,
  textTheme: TextTheme(
    headline1: headline1.copyWith(color: primaryTextColor),
    headline2: headline2.copyWith(color: primaryTextColor),
    headline3: headline3.copyWith(color: primaryTextColor),
    headline4: headline4.copyWith(color: primaryTextColor),
    headline5: headline5.copyWith(color: primaryTextColor),
    bodyText1: textBody1.copyWith(color: primaryTextColor),
    bodyText2: textBody2.copyWith(color: secondaryTextColor),
    subtitle1: subtitle1.copyWith(color: primaryTextColor),
    subtitle2: subtitle2.copyWith(color: primaryTextColor),
    button: button.copyWith(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.grey.shade500,
    type: BottomNavigationBarType.fixed,
  ),
  sliderTheme: SliderThemeData(
    thumbColor: Colors.white,
    overlayColor: successColor.withAlpha(0x1f),
    activeTrackColor: successColor,
    inactiveTrackColor: inactiveTrackColor,
    trackHeight: 2.0,
  ),
  toggleableActiveColor: successColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: successColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      textStyle: button,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        width: 1.0,
        color: successColor.withAlpha(40 * 255 ~/ 100),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        width: 2.0,
        color: successColor.withAlpha(40 * 255 ~/ 100),
      ),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: primaryColor,
  ),
);

ThemeData darkThemeData = ThemeData(
  primaryColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: darkBgColor,
    brightness: Brightness.dark,
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: headline4,
    unselectedLabelStyle: headline4,
    labelColor: Colors.white,
    unselectedLabelColor: Colors.grey.shade300,
  ),
  scaffoldBackgroundColor: darkBgColor,
  secondaryHeaderColor: secondaryDarkBgColor,
  textTheme: TextTheme(
    headline1: headline1.copyWith(color: Colors.white),
    headline2: headline2.copyWith(color: Colors.white),
    headline3: headline3.copyWith(color: Colors.white),
    headline4: headline4.copyWith(color: Colors.white),
    headline5: headline5.copyWith(color: Colors.white),
    bodyText1: textBody1.copyWith(color: Colors.white),
    bodyText2: textBody2.copyWith(color: secondaryTextColor),
    subtitle1: subtitle1.copyWith(color: Colors.white),
    subtitle2: subtitle2.copyWith(color: Colors.white),
    button: button.copyWith(color: Colors.white),
    caption: subtitle2.copyWith(color: secondaryTextColor.withAlpha(142)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: darkBgColor,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white54,
    type: BottomNavigationBarType.fixed,
  ),
  sliderTheme: SliderThemeData(
    thumbColor: Colors.white,
    overlayColor: successColor.withAlpha(0x1f),
    activeTrackColor: successColor,
    inactiveTrackColor: inactiveTrackColor,
    trackHeight: 2.0,
  ),
  toggleableActiveColor: successColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: successColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      textStyle: button,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        width: 1.0,
        color: successColor.withAlpha(40 * 255 ~/ 100),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        width: 2.0,
        color: successColor.withAlpha(40 * 255 ~/ 100),
      ),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: primaryColor,
  ),
);
