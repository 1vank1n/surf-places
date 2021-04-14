import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/screen/place_detail_screen.dart';

/// Карточка достопримечательности для таба «Посетил»
class PlaceVisitedCard extends StatelessWidget {
  final Place place;
  final Function removeHandler;

  PlaceVisitedCard({
    Key? key,
    required this.place,
    required this.removeHandler,
  }) : super(key: key);

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
                    'Цель достигнута 12 окт. 2020',
                    style: Theme.of(context).textTheme.bodyText2,
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
                    onPressed: () {
                      print('Pressed share button');
                    },
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      iconShare,
                      color: Colors.white,
                      width: 24.0,
                      height: 24.0,
                    ),
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
