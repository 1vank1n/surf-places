import 'package:json_annotation/json_annotation.dart';
import 'package:places/ui/screen/res/constants.dart';

part 'places_filter_request_dto.g.dart';

/// Модель данных с параметрами фильтра. Все поля не обязательные, но параметры "lat", "lat" и "radius" зависят друг от друга, поэтому если указан один из них, то остальные два становятся обязательными
@JsonSerializable()
class PlacesFilterRequestDto {
  double? lat;
  double? lng;
  double? radius;
  List<String>? typeFilter;
  String? nameFilter;

  PlacesFilterRequestDto({
    this.typeFilter,
    this.nameFilter,
  });

  PlacesFilterRequestDto.withCoords({
    required this.lat,
    required this.lng,
    required this.radius,
    this.typeFilter,
    this.nameFilter,
  });

  PlacesFilterRequestDto.withRadius({
    this.lat = USER_LAT,
    this.lng = USER_LNG,
    this.typeFilter,
    required this.radius,
  });

  factory PlacesFilterRequestDto.initial() => PlacesFilterRequestDto.withRadius(radius: 5500);

  factory PlacesFilterRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PlacesFilterRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PlacesFilterRequestDtoToJson(this);
}
