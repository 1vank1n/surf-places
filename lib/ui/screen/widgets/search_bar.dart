import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: lightBgColor,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Container(
            width: 24.0,
            child: Center(
              child: SvgPicture.asset(
                iconSearch,
                width: 24.0,
                height: 24.0,
              ),
            ),
          ),
          hintText: 'Поиск',
          suffixIcon: Icon(Icons.filter_alt_rounded),
        ),
      ),
    );
  }
}
