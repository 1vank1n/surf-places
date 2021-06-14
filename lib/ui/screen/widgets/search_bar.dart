import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:redux/redux.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController searchTextEditingController;
  final bool isButton;
  final Function? searchHandler;

  SearchBar({
    required this.searchTextEditingController,
    this.isButton = false,
    this.searchHandler,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    super.initState();

    widget.searchTextEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);

    return Theme(
      data: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: store.state.settingsState.isDark ? deepDarkColor : lightBgColor,
          hintStyle: subtitle1.copyWith(color: secondaryTextColor.withAlpha(142)),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: store.state.settingsState.isDark ? Colors.white : primaryColor,
        ),
        textTheme: TextTheme(
          subtitle1: store.state.settingsState.isDark
              ? subtitle1.copyWith(color: Colors.white)
              : subtitle1.copyWith(color: primaryColor),
        ),
      ),
      child: Stack(
        children: [
          TextField(
            onEditingComplete: () {
              if (widget.searchHandler != null) {
                widget.searchHandler!();
              }
            },
            autofocus: !widget.isButton,
            controller: widget.searchTextEditingController,
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
              suffixIcon: widget.searchTextEditingController.text.isNotEmpty
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 20.0,
                      icon: SvgPicture.asset(
                        iconClear,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        widget.searchTextEditingController.text = '';

                        if (widget.searchHandler != null) {
                          widget.searchHandler!();
                        }
                      },
                    )
                  : null,
            ),
          ),
          if (widget.isButton)
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRouter.placeSearch);
                  },
                  splashColor: successColor.withAlpha(0x88),
                ),
              ),
            ),
          if (widget.isButton)
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.placeFilter);
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
