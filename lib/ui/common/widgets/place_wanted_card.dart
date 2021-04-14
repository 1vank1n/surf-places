import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/place_detail_screen.dart';
import 'package:provider/provider.dart';

/// Карточка достопримечательности для таба «Хочу посетить»
class PlaceWantedCard extends StatelessWidget {
  final Place place;
  final Function removeHandler;

  PlaceWantedCard({
    Key? key,
    required this.place,
    required this.removeHandler,
  }) : super(key: key);

  ThemeData _getPickerThemeData(BuildContext context) {
    return Provider.of<AppModel>(context).theme == lightThemeData
        ? ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: primaryColor))
        : ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(primary: successColor, onBackground: successColor));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              width: double.infinity,
              child: Image.network(
                place.urls.first,
                fit: BoxFit.cover,
                loadingBuilder:
                    (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CupertinoActivityIndicator.partiallyRevealed(
                      progress: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : 1,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: Text(
              place.placeType.toLowerCase(),
              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              color: Theme.of(context).secondaryHeaderColor,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    'Запланировано на 12 окт. 2021',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: successColor),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'закрыто до 09:00',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return PlaceDetailScreen(place: place);
                    },
                  );
                },
                splashColor: successColor.withAlpha(0x88),
              ),
            ),
          ),
          Positioned(
            top: 19.0,
            right: 18.0,
            child: Row(
              children: [
                Container(
                  width: 24.0,
                  height: 24.0,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      iconCalendar,
                      color: Colors.white,
                      width: 24.0,
                      height: 24.0,
                    ),
                    onPressed: () {
                      Platform.isIOS
                          ? showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 240.0,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  child: CupertinoDatePicker(
                                    minimumDate: DateTime.now(),
                                    onDateTimeChanged: (DateTime dateTime) {
                                      print(dateTime);
                                    },
                                  ),
                                );
                              },
                            )
                          : showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return child != null
                                    ? Theme(
                                        data: _getPickerThemeData(context),
                                        child: child,
                                      )
                                    : Container();
                              },
                            );
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 24.0,
                  height: 24.0,
                  child: IconButton(
                    onPressed: () {
                      removeHandler();
                    },
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
