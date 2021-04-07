/// Достопримечательность. Основной класс для формирования фида
class Sight {
  int id;
  String name;
  double lat;
  double lon;
  String url;
  String details;
  String type;

  Sight({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
  });

  @override
  String toString() {
    return '${this.name} [${this.lat}, ${this.lon}]';
  }
}
