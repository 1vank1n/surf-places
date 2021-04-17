import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_respository.dart';

class PlaceInteractor {
  static List<Place> _favoritePlaces = [];
  static List<Place> _visitedPlaces = [];

  static const Map<String, double> USER_COORDINATES = {
    'lat': 60.0,
    'lng': 30.0,
  };

  static Future<List<Place>> getPlaces(double radius, String category) {
    var _filter = PlacesFilterRequestDto.withCoords(
      lat: USER_COORDINATES['lat'],
      lng: USER_COORDINATES['lng'],
      radius: radius,
    );

    return PlaceRepository.postFilteredPlaces(_filter);
  }

  static Future<Place?> getPlaceDetails(int id) {
    return PlaceRepository.getPlace(id);
  }

  static List<Place> getFavoritesPlaces() {
    return _favoritePlaces;
  }

  static void addToFavorites(Place place) {
    if (!_favoritePlaces.contains(place)) {
      _favoritePlaces.add(place);
    }
  }

  static void removeFromFavorites(Place place) {
    if (_favoritePlaces.contains(place)) {
      _favoritePlaces.remove(place);
    }
  }

  static List<Place> getVisitPlaces() {
    return _visitedPlaces;
  }

  static void addToVisitingPlaces(Place place) {
    if (!_visitedPlaces.contains(place)) {
      _visitedPlaces.add(place);
    }
  }

  static void removeFromVisiting(Place place) {
    if (_visitedPlaces.contains(place)) {
      _visitedPlaces.remove(place);
    }
  }

  static Future<Place?> addNewPlace(Place place) {
    return PlaceRepository.postPlace(place);
  }
}
