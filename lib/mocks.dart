import 'dart:math';

import 'package:places/domain/sight.dart';

class SightStorage {
  static List<Sight> sights = [
    Sight(
      id: 4,
      name: 'Морской вокзал',
      lat: 43.580764,
      lon: 39.718618,
      url:
          'https://avatars.mds.yandex.net/get-altay/2804357/2a00000176c93117aa250d052524989c00aa/XXXL',
      details:
          'Порт Сочи  – самый большой, многофункциональный и современный пассажирский порт на Черном море.',
      type: 'Здание',
    ),
    Sight(
      id: 5,
      name: 'Сочинский художественный музей',
      lat: 43.576327,
      lon: 39.728463,
      url:
          'https://avatars.mds.yandex.net/get-altay/1027861/2a000001608b3eaaa218e9563d27a265a6f9/XXXL',
      details:
          'Культурно-просветительское учреждение в Центральном районе города Сочи. Здание построено по проекту академика архитектуры И. В. Жолтовского в 1936 году, предназначалось для Уполномоченного ВЦИК СССР по строительству города-курорта Сочи-Мацеста.',
      type: 'Здание',
    ),
    Sight(
      id: 6,
      name: 'Смотровая башня на горе Ахун',
      lat: 43.550446,
      lon: 39.843491,
      url:
          'https://avatars.mds.yandex.net/get-altay/1420183/2a00000168a9c7071cff85f8cc1194f908d0/XXXL',
      details:
          'На горе Большой Ахун имеется смотровая башня, построенная в 1935-36 гг. по проекту архитектора С. И. Воробьева',
      type: 'Здание',
    ),
  ];

  static List<String> imageList = [
    'http://source.unsplash.com/random/400x400?sig=1',
    'http://source.unsplash.com/random/400x400?sig=2',
    'http://source.unsplash.com/random/400x400?sig=3',
    'http://source.unsplash.com/random/400x400?sig=4',
  ];

  static bool isPointInRangeAtUserPoint({
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

  static List<Sight> filterSight({
    required List<Sight> sights,
    required double userLat,
    required double userLon,
    required double startRange,
    required double endRange,
    Set<String>? types,
    String? query,
  }) {
    List<Sight> _filteredSights = sights;

    if (query != null) {
      _filteredSights = _filteredSights
          .where((sight) =>
              sight.name.toLowerCase().contains(query.toLowerCase()) ||
              sight.type.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    if (types != null) {
      _filteredSights = _filteredSights.where((sight) => types.contains(sight.type)).toList();
    }

    _filteredSights = _filteredSights
        .where((sight) => isPointInRangeAtUserPoint(
              lat: sight.lat,
              lon: sight.lon,
              userLat: userLat,
              userLon: userLon,
              startRange: startRange,
              endRange: endRange,
            ))
        .toList();

    return _filteredSights;
  }
}
