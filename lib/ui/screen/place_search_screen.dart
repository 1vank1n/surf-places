import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/redux/place_search/actions.dart';
import 'package:places/data/redux/place_search/state.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/ui/common/widgets/place_search_card.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/widgets/error_holder.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:redux/redux.dart';

class PlaceSearchScreen extends StatelessWidget {
  final TextEditingController _searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Store<AppState> _store = StoreProvider.of<AppState>(context);

    void _loadQuery(String query) {
      _searchTextEditingController.text = query;
      _searchTextEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchTextEditingController.text.length));
      _store.dispatch(SearchPlaceSearchAction(query));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(
            iconArrow,
            width: 24.0,
            height: 24.0,
            color: Theme.of(context).primaryColor,
          ),
          padding: EdgeInsets.zero,
          color: Colors.white,
        ),
        title: Text(
          'Список интересных мест',
          style: Theme.of(context).textTheme.headline3,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchBar(
              searchTextEditingController: _searchTextEditingController,
              searchHandler: () {
                if (_searchTextEditingController.text.isEmpty) {
                  _store.dispatch(ShowHistoryPlaceSearchAction());
                } else {
                  _store.dispatch(SearchPlaceSearchAction(_searchTextEditingController.text));
                }
              },
            ),
          ),
        ),
        elevation: 0,
      ),
      body: StoreConnector<AppState, PlaceSearchState>(
        converter: (Store<AppState> store) => store.state.placeSearchState,
        builder: (BuildContext context, PlaceSearchState state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.isError) {
            return ErrorHolder(
              message: state.errorMessage,
            );
          } else if (state.isShowQueriesHistory == false) {
            final places = state.places;

            if (places.length > 0) {
              return PlaceFindedList(places: places);
            }

            return EmptyQueryList();
          } else if (state.isLoading == false) {
            return HistoryQueryList(
              loadQueryHandler: _loadQuery,
            );
          }

          throw ArgumentError('Not catch SearchedPlacesState');
        },
      ),
    );
  }
}

class PlaceFindedList extends StatelessWidget {
  final List<Place> places;

  PlaceFindedList({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: places.length,
      itemBuilder: (BuildContext context, int index) {
        final place = places[index];
        return PlaceSearchCard(
          key: ValueKey(place.id),
          place: place,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: dividerColor);
      },
    );
  }
}

class HistoryQueryList extends StatelessWidget {
  final Function loadQueryHandler;

  const HistoryQueryList({
    Key? key,
    required this.loadQueryHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> _store = StoreProvider.of<AppState>(context);

    Widget _queryAndDivider(query) {
      return Column(
        children: [
          ListTile(
            title: Text(query),
            trailing: IconButton(
              onPressed: () {
                _store.dispatch(RemoveQueryFromHistoryPlaceSearchAction(query));
              },
              icon: Icon(
                Icons.close,
                color: inactiveTrackColor,
              ),
            ),
            onTap: () {
              loadQueryHandler(query);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: dividerColor),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: StoreConnector<AppState, List<String>>(
        converter: (Store<AppState> store) => store.state.placeSearchState.queries,
        builder: (BuildContext context, List<String> queries) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (queries.length > 0)
                ListTile(
                  subtitle: Text('ВЫ ИСКАЛИ'),
                ),
              for (var query in queries) _queryAndDivider(query),
              if (queries.length > 0)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextButton(
                    child: Text(
                      'Очистить историю',
                      style: subtitle1.copyWith(
                        fontWeight: FontWeight.w500,
                        color: successColor,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                    ),
                    onPressed: () {
                      _store.dispatch(ClearQueryHistoryPlaceSearchAction());
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class EmptyQueryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Opacity(
          opacity: 0.56,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconSearch,
                width: 64.0,
                height: 64.0,
              ),
              SizedBox(height: 24.0),
              Text(
                'Ничего не найдено.',
                style: headline3,
              ),
              SizedBox(height: 8.0),
              Text(
                'Попробуйте изменить параметры поиска',
                style: textBody1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
