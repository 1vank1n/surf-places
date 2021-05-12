import 'package:places/data/model/place.dart';

abstract class PlaceStorage {
  /// favorites
  List<Place> getFavoritePlaces();
  void addToFavorites(Place place);
  void removeFromFavorites(Place place);

  /// visited
  List<Place> getVisitedPlaces();
  void addToVisitedPlaces(Place place);
  void removeFromVisited(Place place);
}
