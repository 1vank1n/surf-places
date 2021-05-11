import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/network/api.dart';
import 'package:places/data/network/api_dio.dart';
import 'package:places/data/network/exceptions.dart';
import 'package:places/data/repository/place_respository.dart';
import 'package:places/data/store/place_store.dart';
import 'package:places/main.dart';
import 'package:places/ui/common/widgets/place_card.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/widgets/error_holder.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatefulWidget {
  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  late final PlaceStore _placeStore;
  final ScrollController _scrollController = ScrollController();
  final StreamController<double> _titleOpacityStreamController = StreamController();
  final StreamController<List<Place>> _placesStreamController = StreamController();

  @override
  void initState() {
    super.initState();
    Api api = ApiDio();
    PlaceRepository placeRepository = PlaceRepository(api: api);
    _placeStore = PlaceStore(placeRepository: placeRepository);
    _titleOpacityStreamController.sink.add(0);
    _scrollController.addListener(_scrollControllerHandler);
    _getPlaces();
  }

  @override
  void dispose() {
    super.dispose();
    _titleOpacityStreamController.close();
    _placesStreamController.close();
  }

  void _scrollControllerHandler() {
    if (_scrollController.offset > 200) {
      _titleOpacityStreamController.sink.add(1);
    } else if (_scrollController.offset < 100) {
      _titleOpacityStreamController.sink.add(0);
    } else {
      _titleOpacityStreamController.sink.add((_scrollController.offset - 100) / 100);
    }
  }

  void _getPlaces() {
    _placeStore
        .getPlaces(40000, '')
        .then((places) => _placesStreamController.sink.add(places))
        .onError(
      (error, stackTrace) {
        if (error != null) _placesStreamController.addError(error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          bool isLandscape = orientation == Orientation.landscape;

          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () => Future(_getPlaces),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    pinned: true,
                    title: StreamBuilder<double>(
                      stream: _titleOpacityStreamController.stream,
                      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                        if (snapshot.connectionState == ConnectionState.active)
                          return Opacity(
                            opacity: snapshot.data!,
                            child: Text(
                              'Список интересных мест',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          );
                        return Container();
                      },
                    ),
                    expandedHeight: 142.0 + MediaQuery.of(context).padding.top,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: EdgeInsets.symmetric(horizontal: isLandscape ? 0.0 : 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isLandscape
                                ? Text(
                                    'Список интересных мест',
                                    style: Theme.of(context).textTheme.headline3,
                                  )
                                : Text(
                                    'Список\nинтересных мест',
                                    style: Theme.of(context).textTheme.headline1,
                                  ),
                            SizedBox(height: 30.0),
                            SearchBar(
                              searchTextEditingController: TextEditingController(),
                              isButton: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 24.0),
                  ),
                  StreamBuilder<List<Place>>(
                    stream: _placesStreamController.stream,
                    builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        String message;

                        try {
                          DioError dioError = snapshot.error as DioError;
                          NetworkException networkException = dioError.error as NetworkException;
                          message = networkException.toString();
                        } on TypeError {
                          message = 'Что-то пошло не так попробуйте позже';
                        }

                        return SliverFillRemaining(
                          child: ErrorHolder(
                            message: message,
                          ),
                        );
                      } else {
                        final places = snapshot.data ?? [];
                        return CardLayout(
                          orientation: orientation,
                          places: places,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.transparent,
        elevation: 0,
        label: Container(
          height: 48.0,
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                warningColor,
                successColor,
              ],
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Row(
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 8.0,
              ),
              Text(
                'НОВОЕ МЕСТО',
                style: button,
              ),
            ],
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRouter.placeCreate);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CardLayout extends StatelessWidget {
  final Orientation orientation;
  final List<Place> places;

  const CardLayout({
    Key? key,
    required this.orientation,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return orientation == Orientation.portrait
        ? _PortraitCardLayout(places: places)
        : _LandscapeCardLayout(places: places);
  }
}

class _PortraitCardLayout extends StatelessWidget {
  final List<Place> places;

  const _PortraitCardLayout({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Place place = places[index];

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: PlaceCard(
              key: ValueKey(place.id),
              place: place,
            ),
          );
        },
        childCount: places.length,
      ),
    );
  }
}

class _LandscapeCardLayout extends StatelessWidget {
  final List<Place> places;

  const _LandscapeCardLayout({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 34.0,
        mainAxisSpacing: 34.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Place place = places[index];

          return PlaceCard(
            key: ValueKey(place.id),
            place: place,
          );
        },
        childCount: places.length,
      ),
    );
  }
}
