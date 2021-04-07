import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/main.dart';
import 'package:places/main.dart' show AppRouter;
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchTextEditingController;
  final bool isButton;
  final Function? searchHandler;

  SearchBar({
    required this.searchTextEditingController,
    this.isButton = false,
    this.searchHandler,
  });

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
          fillColor:
              Provider.of<AppModel>(context).theme == lightThemeData ? lightBgColor : deepDarkColor,
          hintStyle: subtitle1.copyWith(color: secondaryTextColor.withAlpha(142)),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor:
              Provider.of<AppModel>(context).theme == lightThemeData ? primaryColor : Colors.white,
        ),
        textTheme: TextTheme(
          subtitle1: Provider.of<AppModel>(context).theme == lightThemeData
              ? subtitle1.copyWith(color: primaryColor)
              : subtitle1.copyWith(color: Colors.white),
        ),
      ),
      child: Stack(
        children: [
          TextField(
            onSubmitted: (_) {
              if (searchHandler != null) {
                searchHandler!();
              }
            },
            onEditingComplete: () {
              if (searchHandler != null) {
                searchHandler!();
              }
            },
            autofocus: !isButton,
            controller: searchTextEditingController,
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
              suffixIcon: searchTextEditingController.text.isNotEmpty
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 20.0,
                      icon: SvgPicture.asset(
                        iconClear,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        searchTextEditingController.text = '';

                        if (searchHandler != null) {
                          searchHandler!();
                        }
                      },
                    )
                  : null,
            ),
          ),
          if (isButton)
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRouter.sightSearch);
                  },
                  splashColor: successColor.withAlpha(0x88),
                ),
              ),
            ),
          if (isButton)
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.sightFilter);
                },
                icon: SvgPicture.asset(
                  iconFilter,
                  width: 24.0,
                  height: 24.0,
                ),
              ),
            )
        ],
      ),
    );
  }
}
