import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/redux/place_list/actions.dart';
import 'package:places/data/redux/place_list/state.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/ui/common/widgets/place_favorite_card.dart';
import 'package:places/ui/common/widgets/place_visited_card.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/widgets/error_holder.dart';
import 'package:redux/redux.dart';

class VisitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 108.0,
          title: Text(
            'Избранное',
            style: Theme.of(context).textTheme.headline3,
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: store.state.settingsState.isDark ? deepDarkColor : lightBgColor,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: TabBar(
                  tabs: [
                    Tab(
                      child: Text('Хочу посетить'),
                    ),
                    Tab(
                      child: Text('Посетил'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            StoreConnector<AppState, PlaceListState>(
              converter: (Store<AppState> store) => store.state.placeListState,
              builder: (BuildContext context, PlaceListState state) {
                if (state.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.isError) {
                  return ErrorHolder(
                    message: state.errorMessage,
                  );
                } else {
                  return FavoritePlaceList(places: state.favoritePlaces);
                }
              },
            ),
            StoreConnector<AppState, PlaceListState>(
              converter: (Store<AppState> store) => store.state.placeListState,
              builder: (BuildContext context, PlaceListState state) {
                if (state.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.isError) {
                  return ErrorHolder(
                    message: state.errorMessage,
                  );
                } else {
                  return VisitedPlaceList(places: state.visitedPlaces);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritePlaceList extends StatelessWidget {
  final List<Place> places;

  FavoritePlaceList({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void removeHandler(Place place) {
      Store<AppState> store = StoreProvider.of<AppState>(context);
      store.dispatch(RemovePlaceFromFavoritesPlaceListAction(place: place));
    }

    return places.length > 0
        ? ReorderableListView.builder(
            padding: const EdgeInsets.only(
              top: 22.0,
              right: 16.0,
              left: 16.0,
            ),
            itemCount: places.length,
            physics: Platform.isIOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              Place place = places[index];

              return Dismissible(
                key: ValueKey(place.name),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  removeHandler(place);
                },
                background: RemoveBackground(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: PlaceFavoriteCard(
                    key: ValueKey(place.id),
                    place: place,
                    removeHandler: () {
                      removeHandler(place);
                    },
                  ),
                ),
              );
            },
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }

              final Place place = places.removeAt(oldIndex);
              places.insert(newIndex, place);
            },
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Opacity(
                opacity: 0.56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      iconCamera,
                      width: 64.0,
                      height: 64.0,
                      color: secondaryTextColor,
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      'Пусто',
                      style: headline3,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Отмечайте понравившиеся места и они появиятся здесь.',
                      style: textBody1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class VisitedPlaceList extends StatelessWidget {
  final List<Place> places;

  VisitedPlaceList({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void removeHandler(Place place) {
      Store<AppState> store = StoreProvider.of<AppState>(context);
      store.dispatch(RemovePlaceFromVisitedPlaceListAction(place: place));
    }

    return places.length > 0
        ? ReorderableListView.builder(
            padding: const EdgeInsets.only(
              top: 22.0,
              right: 16.0,
              left: 16.0,
            ),
            itemCount: places.length,
            physics: Platform.isIOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              Place place = places[index];

              return Dismissible(
                key: ValueKey(place.name),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  removeHandler(place);
                },
                background: RemoveBackground(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: PlaceVisitedCard(
                    key: ValueKey(place.id),
                    place: place,
                    removeHandler: () {
                      removeHandler(place);
                    },
                  ),
                ),
              );
            },
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }

              final Place place = places.removeAt(oldIndex);
              places.insert(newIndex, place);
            },
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Opacity(
                opacity: 0.56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      iconGo,
                      width: 64.0,
                      height: 64.0,
                      color: secondaryTextColor,
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      'Пусто',
                      style: headline3,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Завершите маршрут, чтобы место попало сюда.',
                      style: textBody1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class RemoveBackground extends StatelessWidget {
  const RemoveBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(iconBucket),
              SizedBox(height: 8.0),
              Text(
                'Удалить',
                style: subtitle2.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
