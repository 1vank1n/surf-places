/// Модель данных мест (достопримечательностей)
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

  factory Place.fromJson(Map<String, dynamic> json) {
    final List<String> urls = [];
    for (var url in json['urls']) {
      urls.add(url as String);
    }

    return Place(
      id: json['id'],
      lat: json['lat'],
      lng: json['lng'],
      name: json['name'],
      urls: urls,
      placeType: json['placeType'],
      description: json['description'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> get json {
    return {
      'lat': lat,
      'lng': lng,
      'name': name,
      'urls': urls,
      'placeType': placeType,
      'description': description,
    };
  }

  String excerpt() {
    const maxLength = 100;

    return this.description.length > maxLength
        ? '${this.description.substring(0, maxLength)}...'
        : this.description;
  }

  @override
  String toString() {
    return '${this.name} [${this.lat}, ${this.lng}]';
  }
}
