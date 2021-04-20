import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/screen/place_detail_screen.dart';

/// Карточка достопримечательности. Виджет используется в фиде
class PlaceCard extends StatefulWidget {
  final Place place;

  PlaceCard({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  final PlaceInteractor _placeInteractor = PlaceInteractor();

  bool _placeInFavorites(Place place) {
    return _placeInteractor.getFavoritesPlaces().contains(place);
  }

  void _addToFavorites(Place place) {
    _placeInteractor.addToFavorites(place);
    setState(() {});
  }

  void _removeFromFavorites(Place place) {
    _placeInteractor.removeFromFavorites(place);
    setState(() {});
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
                widget.place.urls.first,
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
              widget.place.placeType.toLowerCase(),
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
                    widget.place.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    widget.place.excerpt(),
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
                      return PlaceDetailScreen(id: widget.place.id);
                    },
                  );
                },
                splashColor: successColor.withAlpha(0x88),
              ),
            ),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: Container(
              width: 24.0,
              height: 24.0,
              child: IconButton(
                onPressed: () {
                  _placeInFavorites(widget.place)
                      ? _removeFromFavorites(widget.place)
                      : _addToFavorites(widget.place);
                },
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  _placeInFavorites(widget.place) ? iconHeartFill : iconHeart,
                  color: Colors.white,
                  width: 24.0,
                  height: 24.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}