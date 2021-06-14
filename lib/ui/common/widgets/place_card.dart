import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/redux/place_list/actions.dart';
import 'package:places/data/redux/place_list/state.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/screen/place_detail_screen.dart';
import 'package:redux/redux.dart';

/// Карточка достопримечательности. Виджет используется в фиде
class PlaceCard extends StatelessWidget {
  final Place place;

  PlaceCard({
    Key? key,
    required this.place,
  }) : super(key: key);

  void _addToFavorites(Store<AppState> store, Place place) {
    store.dispatch(AddPlaceToFavoritesPlaceListAction(place: place));
  }

  void _removeFromFavorites(Store<AppState> store, Place place) {
    store.dispatch(RemovePlaceFromFavoritesPlaceListAction(place: place));
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
                    place.excerpt(),
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
                      return PlaceDetailScreen(id: place.id);
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
              child: StoreConnector<AppState, PlaceListState>(
                converter: (Store<AppState> store) => store.state.placeListState,
                builder: (BuildContext context, PlaceListState state) {
                  if (!state.isLoading & !state.isError) {
                    bool isFavorited = state.favoritePlaces.contains(place);
                    Store<AppState> store = StoreProvider.of<AppState>(context);

                    return IconButton(
                      onPressed: () {
                        isFavorited
                            ? _removeFromFavorites(store, place)
                            : _addToFavorites(store, place);
                      },
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        isFavorited ? iconHeartFill : iconHeart,
                        color: Colors.white,
                        width: 24.0,
                        height: 24.0,
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
