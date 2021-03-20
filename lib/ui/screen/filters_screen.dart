import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
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
        .toList();
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
            'res/icons/icon-arrow.svg',
            width: 24.0,
            height: 24.0,
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
            ListTile(
              title: Text('Расстояние'),
              trailing: Text(
                'от $_currentMin до $_currentMax',
                style: subtitle2.copyWith(color: secondaryTextColor),
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
}
