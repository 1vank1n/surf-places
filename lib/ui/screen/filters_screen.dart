import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  static const double MIN_RANGE = 100.0;
  static const double MAX_RANGE = 10000.0;
  static const double START_RANGE = 100.0;
  static const double END_RANGE = 5500.0;
  static const Map<String, double> USER_COORDINATES = {
    'lat': 43.575402,
    'lon': 39.728811,
  };

  RangeValues _currentRangeValues = RangeValues(START_RANGE, END_RANGE);
  List<Sight> sights = mocks;
  List<Sight>? _filteredSights;
  Set<String> _filteredTypes = {'Здание', 'Памятник', 'Кафе'};

  String formatRange(double value) {
    return value < 1000
        ? '${value.toInt().toString()} м'
        : '${(value / 1000).toStringAsFixed(1)} км';
  }

  String get _currentMin => formatRange(_currentRangeValues.start);
  String get _currentMax => formatRange(_currentRangeValues.end);

  bool isPointInRangeAtUserPoint({
    required double lat,
    required double lon,
    required double userLat,
    required double userLon,
    required double startRange,
    required double endRange,
  }) {
    const double ky = 40000000 / 360;
    double kx = cos(pi * userLat / 180.0) * ky;
    double dx = (userLon - lon).abs() * kx;
    double dy = (userLat - lat).abs() * ky;
    double distance = sqrt(dx * dx + dy * dy);
    if (startRange <= 100.0) startRange = 0;
    return startRange <= distance && distance <= endRange;
  }

  List<Sight> filterSight(List<Sight> sights) {
    return sights
        .where((sight) => isPointInRangeAtUserPoint(
              lat: sight.lat,
              lon: sight.lon,
              userLat: USER_COORDINATES['lat']!,
              userLon: USER_COORDINATES['lon']!,
              startRange: _currentRangeValues.start,
              endRange: _currentRangeValues.end,
            ))
        .where((sight) => _filteredTypes.contains(sight.type))
        .toList();
  }

  void toggleTypeInFilteredTypes(String type) {
    setState(() {
      if (_filteredTypes.contains(type)) {
        _filteredTypes.remove(type);
      } else {
        _filteredTypes.add(type);
      }

      _filteredSights = filterSight(sights);
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredSights = filterSight(sights);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            print('Pressed icon button');
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
            onPressed: () {},
            child: Text(
              'Очистить',
              style: subtitle1.copyWith(color: successColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40.0,
            ),
            _buildCategoriesFilter(),
            _buildRangeSlider(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.infinity,
            height: 48.0,
            child: ElevatedButton(
              onPressed: () {
                print(_filteredSights);
              },
              child: _filteredSights == null
                  ? CupertinoActivityIndicator()
                  : Text('ПОКАЗАТЬ (${_filteredSights!.length})'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          ListTile(
            subtitle: Text('КАТЕГОРИЯ'),
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
                isSelected: _filteredTypes.contains('Здание'),
              ),
              CategoryButton(
                context: context,
                iconAsset: iconPark,
                title: 'Памятники',
                onPressed: () {
                  toggleTypeInFilteredTypes('Памятник');
                },
                isSelected: _filteredTypes.contains('Памятник'),
              ),
              CategoryButton(
                context: context,
                iconAsset: iconCafe,
                title: 'Кафе',
                onPressed: () {
                  toggleTypeInFilteredTypes('Кафе');
                },
                isSelected: _filteredTypes.contains('Кафе'),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }

  Widget _buildRangeSlider() {
    return Column(
      children: [
        ListTile(
          title: Text('Расстояние'),
          trailing: Text(
            'от $_currentMin до $_currentMax',
            style: subtitle1.copyWith(color: secondaryTextColor),
          ),
        ),
        RangeSlider(
          values: _currentRangeValues,
          min: MIN_RANGE,
          max: MAX_RANGE,
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
          onChangeEnd: (RangeValues values) {
            setState(() {
              _filteredSights = filterSight(sights);
            });
          },
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
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
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
