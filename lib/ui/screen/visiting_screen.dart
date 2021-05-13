import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/bloc/visiting_place/favorite_place_bloc.dart';
import 'package:places/data/bloc/visiting_place/favorite_place_event.dart';
import 'package:places/data/bloc/visiting_place/favorite_place_state.dart';
import 'package:places/data/bloc/visiting_place/visited_place_bloc.dart';
import 'package:places/data/bloc/visiting_place/visited_place_event.dart';
import 'package:places/data/bloc/visiting_place/visited_place_state.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_respository.dart';
import 'package:places/main.dart';
import 'package:places/ui/common/widgets/place_visited_card.dart';
import 'package:places/ui/common/widgets/place_favorite_card.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

class VisitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoritePlaceBloc>(
          create: (context) => FavoritePlaceBloc(
            placeRepository: context.read<PlaceRepository>(),
          )..add(LoadFavoritePlacesEvent()),
        ),
        BlocProvider<VisitedPlaceBloc>(
          create: (context) => VisitedPlaceBloc(
            placeRepository: context.read<PlaceRepository>(),
          )..add(LoadVisitedPlacesEvent()),
        ),
      ],
      child: DefaultTabController(
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
                    color: Provider.of<AppModel>(context).theme == lightThemeData
                        ? lightBgColor
                        : deepDarkColor,
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
              BlocBuilder<FavoritePlaceBloc, FavoritePlaceState>(
                  builder: (BuildContext context, FavoritePlaceState state) {
                if (state is LoadingFavoritePlacesState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is LoadedFavoritePlacesState) {
                  return FavoritePlaceList(places: state.favoritePlaces);
                }

                throw ArgumentError('Not cacth FavoritePlaceState');
              }),
              BlocBuilder<VisitedPlaceBloc, VisitedPlaceState>(
                  builder: (BuildContext context, VisitedPlaceState state) {
                if (state is LoadingVisitedPlacesState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is LoadedVisitedPlacesState) {
                  return VisitedPlaceList(places: state.visitedPlaces);
                }

                throw ArgumentError('Not cacth VisitedPlaceState');
              }),
            ],
          ),
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
      context.read<FavoritePlaceBloc>().add(RemoveFromFavoritePlacesEvent(place));
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
      context.read<FavoritePlaceBloc>().add(RemoveFromFavoritePlacesEvent(place));
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
