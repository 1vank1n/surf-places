import 'package:places/data/model/place.dart';
import 'package:places/data/storage/place_storage.dart';

class PlaceStorageSession implements PlaceStorage {
  final List<Place> _favoritePlaces = [];
  final List<Place> _visitedPlaces = [];

  List<Place> getFavoritePlaces() {
    return _favoritePlaces;
  }

  void addToFavorites(Place place) {
    if (!_favoritePlaces.contains(place)) {
      _favoritePlaces.add(place);
    }
  }

  void removeFromFavorites(Place place) {
    if (_favoritePlaces.contains(place)) {
      _favoritePlaces.remove(place);
    }
  }

  List<Place> getVisitedPlaces() {
    return _visitedPlaces;
  }

  void addToVisitedPlaces(Place place) {
    if (!_visitedPlaces.contains(place)) {
      _visitedPlaces.add(place);
    }
  }

  void removeFromVisited(Place place) {
    if (_visitedPlaces.contains(place)) {
      _visitedPlaces.remove(place);
    }
  }
}
