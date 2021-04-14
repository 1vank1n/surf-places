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

  Map<String, dynamic> get json {
    return {
      'lat': lat,
      'lng': lng,
      'radius': radius,
      'typeFilter': typeFilter ?? [],
      'nameFilter': nameFilter ?? '',
    };
  }
}
