/// Модель данных с параметрами фильтра. Все поля не обязательные, но параметры "lat", "lat" и "radius" зависят друг от друга, поэтому если указан один из них, то остальные два становятся обязательными
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
    this.lat = 43.575402,
    this.lng = 39.728811,
    required this.radius,
  });

  factory PlacesFilterRequestDto.initial() => PlacesFilterRequestDto.withRadius(radius: 40000);

  factory PlacesFilterRequestDto.fromJson(Map<String, dynamic> json) {
    return PlacesFilterRequestDto.withCoords(
      lat: json['lat'],
      lng: json['lng'],
      radius: json['radius'],
      typeFilter: json['typeFilter'],
      nameFilter: json['nameFilter'],
    );
  }

  Map<String, dynamic> get json {
    return {
      'lat': lat,
      'lng': lng,
      'radius': radius,
      'typeFilter': typeFilter,
      'nameFilter': nameFilter,
    };
  }
}
