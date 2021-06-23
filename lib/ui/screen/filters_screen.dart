import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/filter_category.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/redux/filters/actions.dart';
import 'package:places/data/redux/filters/state.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/data/repository/settings_repository.dart';
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

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final state = await SettingsRepository().getFiltersState();
    _store = StoreProvider.of<AppState>(context);
    _store.dispatch(SetStateFiltersAction(state: state));
    _store.dispatch(LoadFiltersAction(filter: state.generateFilter()));
  }

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
                  _store.dispatch(LoadFiltersAction(filter: PlacesFilterRequestDto.initial()));
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
                        RangeSightSlider(startRangeValues: _currentRangeValues),
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
    final store = StoreProvider.of<AppState>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          height: 48.0,
          child: ElevatedButton(
            onPressed: () async {
              await SettingsRepository().setFiltersState(store.state.filtersState);
              Navigator.of(context).pop(true);
            },
            child: count == null ? CupertinoActivityIndicator() : Text('ПОКАЗАТЬ ($count)'),
          ),
        ),
      ),
    );
  }
}

class CategoriesFilterGrid extends StatelessWidget {
  final Set<FilterCategory> filteredTypes;

  CategoriesFilterGrid({
    Key? key,
    required this.filteredTypes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListTile(
          subtitle: Text('КАТЕГОРИИ'),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          children: [
            for (var filterCategory in FilterCategory.initialSet())
              CategoryButton(
                context: context,
                filterCategory: filterCategory,
              ),
          ],
        ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final BuildContext context;
  final FilterCategory filterCategory;

  const CategoryButton({
    Key? key,
    required this.context,
    required this.filterCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return Column(
      children: [
        StoreConnector<AppState, Set<FilterCategory>>(
            converter: (store) => store.state.filtersState.filteredTypes,
            builder: (BuildContext context, Set<FilterCategory> filteredTypes) {
              bool isSelected = filteredTypes.contains(filterCategory);

              return Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  color: isSelected ? successColor.withAlpha(0x6f) : successColor.withAlpha(0x20),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: IconButton(
                  onPressed: () {
                    store.dispatch(UpdateFiltersAction(filterCategory: filterCategory));
                    store.dispatch(
                        LoadFiltersAction(filter: store.state.filtersState.generateFilter()));
                  },
                  icon: SvgPicture.asset(filterCategory.icon),
                  padding: EdgeInsets.zero,
                ),
              );
            }),
        SizedBox(
          height: 12.0,
        ),
        Text(
          filterCategory.title,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}

class RangeSightSlider extends StatelessWidget {
  static const double MIN_RANGE = 100.0;
  static const double MAX_RANGE = 30000.0;
  final RangeValues startRangeValues;

  RangeSightSlider({
    Key? key,
    required this.startRangeValues,
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
    final store = StoreProvider.of<AppState>(context);

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
            store.dispatch(
              UpdateFiltersAction(
                startRange: values.start,
                endRange: values.end,
              ),
            );
          },
          onChangeEnd: (RangeValues values) {
            store.dispatch(
              LoadFiltersAction(filter: store.state.filtersState.generateFilter()),
            );
          },
        ),
      ],
    );
  }
}
