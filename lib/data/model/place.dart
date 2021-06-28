import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

/// Модель данных мест (достопримечательностей)
@JsonSerializable()
class Place {
  int id;
  double lat;
  double lng;
  String name;
  List<String> urls;
  String placeType;
  String description;
  double? distance;

  Place({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
    this.distance,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  String excerpt() {
    const maxLength = 100;

    return this.description.length > maxLength
        ? '${this.description.substring(0, maxLength)}...'
        : this.description;
  }

  bool isPointInRangeAtUserPoint({
    required double userLat,
    required double userLng,
    required double startRange,
    required double endRange,
  }) {
    const double ky = 40000000 / 360;
    double kx = cos(pi * userLat / 180.0) * ky;
    double dx = (userLng - this.lng).abs() * kx;
    double dy = (userLat - this.lat).abs() * ky;
    double distance = sqrt(dx * dx + dy * dy);
    if (startRange <= 100.0) startRange = 0;
    return startRange <= distance && distance <= endRange;
  }

  @override
  bool operator ==(other) {
    return (other is Place) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return '${this.name} [${this.lat}, ${this.lng}]';
  }
}
