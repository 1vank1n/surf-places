import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/redux/place_list/actions.dart';
import 'package:places/data/redux/place_list/state.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/main.dart';
import 'package:places/ui/common/widgets/loader.dart';
import 'package:places/ui/common/widgets/place_card.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/widgets/error_holder.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:redux/redux.dart';

class PlaceListScreen extends StatefulWidget {
  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  final ScrollController _scrollController = ScrollController();
  final StreamController<double> _titleOpacityStreamController = StreamController();

  @override
  void initState() {
    super.initState();
    _titleOpacityStreamController.sink.add(0);
    _scrollController.addListener(_scrollControllerHandler);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Store<AppState> store = StoreProvider.of<AppState>(context);
    store.dispatch(LoadPlaceListAction());
  }

  @override
  void dispose() {
    super.dispose();
    _titleOpacityStreamController.close();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          bool isLandscape = orientation == Orientation.landscape;

          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () => Future(() {
                Store<AppState> store = StoreProvider.of<AppState>(context);
                store.dispatch(LoadPlaceListAction());
              }),
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
                  StoreConnector<AppState, PlaceListState>(
                    converter: (Store<AppState> store) => store.state.placeListState,
                    builder: (BuildContext context, PlaceListState state) {
                      if (state.isLoading) {
                        return SliverFillRemaining(
                          child: Center(
                            child: Loader(),
                          ),
                        );
                      } else if (state.isError) {
                        return SliverFillRemaining(
                          child: ErrorHolder(
                            message: state.errorMessage,
                          ),
                        );
                      } else {
                        return CardLayout(
                          orientation: orientation,
                          places: state.places,
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
