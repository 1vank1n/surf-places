import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/sight_search_card.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

class SightSearchScreen extends StatefulWidget {
  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  static const double START_RANGE = 0.0;
  static const double END_RANGE = 5500.0;
  static const Map<String, double> USER_COORDINATES = {
    'lat': 43.575402,
    'lon': 39.728811,
  };

  final RangeValues _currentRangeValues = RangeValues(START_RANGE, END_RANGE);
  TextEditingController _searchTextEditingController = TextEditingController();
  List<Sight> _sights = [];
  List<String> _queries = [];

  @override
  void initState() {
    super.initState();
  }

  List<Sight> _searchByQuery(String query) {
    List<Sight> storageSights = SightStorage.sights;

    if (query != '') {
      if (!_queries.contains(query)) {
        _queries.add(query);
      } else {
        _queries.remove(query);
        _queries.insert(0, query);
      }
    }

    if (query.length > 0) {
      return SightStorage.filterSight(
        sights: storageSights,
        userLat: USER_COORDINATES['lat']!,
        userLon: USER_COORDINATES['lon']!,
        startRange: _currentRangeValues.start,
        endRange: _currentRangeValues.end,
        query: query,
      );
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  _sights = _searchByQuery(_searchTextEditingController.text);
                });
              },
            ),
          ),
        ),
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildQuery() {
    Widget _sightSearchCardAndDivider(Sight sight) {
      return Column(
        children: [
          SightSearchCard(
            sight: sight,
            highlight: _searchTextEditingController.text,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: dividerColor),
          )
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 26.0),
          for (var sight in _sights) _sightSearchCardAndDivider(sight),
        ],
      ),
    );
  }

  Widget _buildHistory() {
    Widget _queryAndDivider(query) {
      return Column(
        children: [
          ListTile(
            title: Text(query),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _queries.remove(query);
                });
              },
              icon: Icon(
                Icons.close,
                color: inactiveTrackColor,
              ),
            ),
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
          if (_queries.length > 0)
            ListTile(
              subtitle: Text('ВЫ ИСКАЛИ'),
            ),
          for (var query in _queries) _queryAndDivider(query),
          if (_queries.length > 0)
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
                  setState(() {
                    _queries = [];
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyQuery() {
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

  Widget _buildBody() {
    if (_sights.length > 0) {
      return _buildQuery();
    }

    if (_searchTextEditingController.text.isEmpty) {
      return _buildHistory();
    }

    return _buildEmptyQuery();
  }
}
