import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/network/api.dart';

class PlaceRepository {
  final List<Place> _favoritePlaces = [];
  final List<Place> _visitedPlaces = [];
  final Api api;

  PlaceRepository({required this.api});

  Future<List<Place>> getPlaces() async {
    return api.getPlaces();
  }

  Future<Place?> getPlace(int id) async {
    return api.getPlace(id);
  }

  Future<Place?> postPlace(Place place) async {
    return api.postPlace(place);
  }

  Future<Place?> putPlace(Place place) async {
    return api.putPlace(place);
  }

  Future<bool> deletePlace(int id) async {
    return api.deletePlace(id);
  }

  Future<List<Place>> postFilteredPlaces(PlacesFilterRequestDto placesFilter) async {
    return api.postFilteredPlaces(placesFilter);
  }

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
