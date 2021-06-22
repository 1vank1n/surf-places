import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/redux/filters/actions.dart';
import 'package:places/data/redux/filters/state.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/constants.dart';
import 'package:redux/redux.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late Store<AppState> _store;
  // RangeValues _currentRangeValues = RangeValues(START_RANGE, END_RANGE);
  // List<Place> _places = [];
  // List<Place>? _filteredPlaces;
  // Set<String> _filteredTypes = {
  //   'Здание',
  //   'Памятник',
  //   'Кафе',
  // };

  PlacesFilterRequestDto get _filter => PlacesFilterRequestDto.withRadius(radius: radius);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    _store.dispatch(LoadFiltersAction(filter: filter));
  }

  Future<List<Place>> _filterPlaces() async {
    // TODO
    // return  SightStorage.filterSight(
    //   sights: _places,
    //   userLat: USER_COORDINATES['lat']!,
    //   userLon: USER_COORDINATES['lon']!,
    //   startRange: _currentRangeValues.start,
    //   endRange: _currentRangeValues.end,
    //   types: _filteredTypes,
    // );
    return [];
  }

  // void _toggleTypeInFilteredTypes(String type) {
  //   setState(() {
  //     if (_filteredTypes.contains(type)) {
  //       _filteredTypes.remove(type);
  //     } else {
  //       _filteredTypes.add(type);
  //     }

  //     _filteredSights = _filterPlaces();
  //   });
  // }

  void _changeCurrentRangeValues(RangeValues values) {
    // TODO
    // setState(() {
    //   _currentRangeValues = values;
    //   _filteredSights = _filterPlaces();
    // });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _filteredSights = _filterPlaces();
  // }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        bool isSmallScreen = MediaQuery.of(context).size.width <= SMALL_SCREEN_WIDTH;

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
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
            actions: [
              TextButton(
                child: Text(
                  'Очистить',
                  style: subtitle1.copyWith(
                    color: successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  // TODO
                  // _store.dispatch(action);
                },
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: StoreConnector<AppState, FiltersState>(
                  converter: (store) => store.state.filtersState,
                  builder: (BuildContext context, FiltersState state) {
                    RangeValues _currentRangeValues = RangeValues(
                      state.startRange,
                      state.endRange,
                    );

                    return Column(
                      children: [
                        CategoriesFilterGrid(filteredTypes: state.filteredTypes),
                        SizedBox(height: isSmallScreen ? 20.0 : 40.0),
                        RangeSightSlider(
                          startRangeValues: _currentRangeValues,
                          changeCurrentRangeValues: _changeCurrentRangeValues,
                          filterSight: _filterPlaces,
                        ),
                        if (isSmallScreen) SizedBox(height: 20.0),
                        if (isSmallScreen) ShowButton(count: state.count),
                      ],
                    );
                  }),
            ),
          ),
          bottomNavigationBar: isSmallScreen
              ? null
              : StoreConnector<AppState, FiltersState>(
                  converter: (store) => store.state.filtersState,
                  builder: (BuildContext context, FiltersState state) {
                    return ShowButton(count: state.count);
                  },
                ),
        );
      },
    );
  }
}

class ShowButton extends StatelessWidget {
  final int? count;

  const ShowButton({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          height: 48.0,
          child: ElevatedButton(
            onPressed: () {
              // TODO
              // print(_filteredSights);
            },
            child: count == null ? CupertinoActivityIndicator() : Text('ПОКАЗАТЬ ($count)'),
          ),
        ),
      ),
    );
  }
}

class CategoriesFilterGrid extends StatelessWidget {
  final Set<String> filteredTypes;

  CategoriesFilterGrid({
    Key? key,
    required this.filteredTypes,
  }) : super(key: key);

  void toggleTypeInFilteredTypes(String title) {
    // TODO
    //
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListTile(
          subtitle: Text('КАТЕГОРИИ'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryButton(
              context: context,
              iconAsset: iconMuseum,
              title: 'Здания',
              onPressed: () {
                toggleTypeInFilteredTypes('Здание');
              },
              isSelected: filteredTypes.contains('Здание'),
            ),
            CategoryButton(
              context: context,
              iconAsset: iconPark,
              title: 'Памятники',
              onPressed: () {
                toggleTypeInFilteredTypes('Памятник');
              },
              isSelected: filteredTypes.contains('Памятник'),
            ),
            CategoryButton(
              context: context,
              iconAsset: iconCafe,
              title: 'Кафе',
              onPressed: () {
                toggleTypeInFilteredTypes('Кафе');
              },
              isSelected: filteredTypes.contains('Кафе'),
            ),
          ],
        ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final BuildContext context;
  final String iconAsset;
  final String title;
  final VoidCallback onPressed;
  final bool isSelected;

  const CategoryButton({
    Key? key,
    required this.context,
    required this.iconAsset,
    required this.title,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64.0,
          height: 64.0,
          decoration: BoxDecoration(
            color: isSelected ? successColor.withAlpha(0x6f) : successColor.withAlpha(0x20),
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: SvgPicture.asset(iconAsset),
            padding: EdgeInsets.zero,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}

class RangeSightSlider extends StatelessWidget {
  static const double MIN_RANGE = 100.0;
  static const double MAX_RANGE = 10000.0;
  final RangeValues startRangeValues;
  final Function changeCurrentRangeValues;
  final Function filterSight;

  RangeSightSlider({
    Key? key,
    required this.startRangeValues,
    required this.changeCurrentRangeValues,
    required this.filterSight,
  }) : super(key: key);

  String formatRange(double value) {
    return value < 1000
        ? '${value.toInt().toString()} м'
        : '${(value / 1000).toStringAsFixed(1)} км';
  }

  String get _currentMin => formatRange(startRangeValues.start);
  String get _currentMax => formatRange(startRangeValues.end);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListTile(
          title: Text('Расстояние'),
          trailing: Text(
            'от $_currentMin до $_currentMax',
            style: subtitle1.copyWith(color: secondaryTextColor),
          ),
        ),
        RangeSlider(
          values: startRangeValues,
          min: RangeSightSlider.MIN_RANGE,
          max: RangeSightSlider.MAX_RANGE,
          onChanged: (RangeValues values) {
            changeCurrentRangeValues(values);
          },
          onChangeEnd: (RangeValues values) {
            filterSight();
          },
        ),
      ],
    );
  }
}
