import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_respository.dart';

class PlaceInteractor {
  static List<Place> _favoritePlaces = [];
  static List<Place> _visitedPlaces = [];
  Map<String, double> userCoordinates = {
    'lat': 60.0,
    'lng': 30.0,
  };

  Future<List<Place>> getPlaces(double radius, String category) {
    PlacesFilterRequestDto _filter = PlacesFilterRequestDto.withCoords(
      lat: userCoordinates['lat'],
      lng: userCoordinates['lng'],
      radius: radius,
    );

    return PlaceRepository().postFilteredPlaces(_filter);
  }

  Future<Place?> getPlaceDetails(int id) {
    return PlaceRepository().getPlace(id);
  }

  List<Place> getFavoritesPlaces() {
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

  List<Place> getVisitPlaces() {
    return _visitedPlaces;
  }

  void addToVisitingPlaces(Place place) {
    if (!_visitedPlaces.contains(place)) {
      _visitedPlaces.add(place);
    }
  }

  void removeFromVisiting(Place place) {
    if (_visitedPlaces.contains(place)) {
      _visitedPlaces.remove(place);
    }
  }

  Future<Place?> addNewPlace(Place place) {
    return PlaceRepository().postPlace(place);
  }
}