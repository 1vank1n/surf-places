import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/place_search_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/network/exceptions.dart';
import 'package:places/ui/common/widgets/place_search_card.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/widgets/error_holder.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class PlaceSearchScreen extends StatefulWidget {
  @override
  _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  late final PlaceSearchInteractor _placeSearchInteractor;
  late Future<List<Place>> _places;
  final TextEditingController _searchTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _placeSearchInteractor = context.read<PlaceSearchInteractor>();
    _places = Future.value([]);
  }

  Future<List<Place>> _searchByQuery(String query) {
    if (query == '') {
      return Future.value([]);
    }

    return _placeSearchInteractor.searchPlaces(query);
  }

  void _loadQuery(String query) {
    setState(() {
      _searchTextEditingController.text = query;
      _searchTextEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchTextEditingController.text.length));
      _places = _searchByQuery(query);
    });
  }

  void _refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                setState(() {
                  _places = _searchByQuery(_searchTextEditingController.text);
                });
              },
            ),
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _places,
        builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
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

            return ErrorHolder(
              message: message,
            );
          } else {
            final places = snapshot.data ?? [];

            if (places.length > 0) {
              return PlaceFindedList(places: places);
            }

            if (_searchTextEditingController.text.isEmpty) {
              return HistoryQueryList(
                placeSearchInteractor: _placeSearchInteractor,
                loadQueryHandler: _loadQuery,
                refreshStateHandler: _refreshState,
              );
            }

            return EmptyQueryList();
          }
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
  final PlaceSearchInteractor placeSearchInteractor;
  final Function loadQueryHandler;
  final Function refreshStateHandler;

  const HistoryQueryList({
    Key? key,
    required this.placeSearchInteractor,
    required this.loadQueryHandler,
    required this.refreshStateHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _queryAndDivider(query) {
      return Column(
        children: [
          ListTile(
            title: Text(query),
            trailing: IconButton(
              onPressed: () {
                placeSearchInteractor.removeQuery(query);
                refreshStateHandler();
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (placeSearchInteractor.queries.length > 0)
            ListTile(
              subtitle: Text('ВЫ ИСКАЛИ'),
            ),
          for (var query in placeSearchInteractor.queries) _queryAndDivider(query),
          if (placeSearchInteractor.queries.length > 0)
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
                  placeSearchInteractor.cleanQueries();
                  refreshStateHandler();
                },
              ),
            ),
        ],
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
