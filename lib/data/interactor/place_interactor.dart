import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_respository.dart';

class PlaceInteractor {
  final PlaceRepository placeRepository;

  final Map<String, double> userCoordinates = {
    'lat': 60.0,
    'lng': 30.0,
  };

  PlaceInteractor({
    required this.placeRepository,
  });

  Future<List<Place>> getPlaces(double radius, String category) {
    PlacesFilterRequestDto _filter = PlacesFilterRequestDto.withCoords(
      lat: userCoordinates['lat'],
      lng: userCoordinates['lng'],
      radius: radius,
    );

    return placeRepository.postFilteredPlaces(_filter);
  }

  Future<Place?> getPlaceDetails(int id) {
    return placeRepository.getPlace(id);
  }

  Future<List<Place>> getFavoritesPlaces() {
    return placeRepository.getFavoritePlaces();
  }

  void addToFavorites(Place place) {
    placeRepository.addToFavorites(place);
  }

  void removeFromFavorites(Place place) {
    placeRepository.removeFromFavorites(place);
  }

  Future<List<Place>> getVisitPlaces() {
    return placeRepository.getVisitedPlaces();
  }

  void addToVisitingPlaces(Place place) {
    placeRepository.addToVisitedPlaces(place);
  }

  void removeFromVisiting(Place place) {
    placeRepository.removeFromVisited(place);
  }

  Future<Place?> addNewPlace(Place place) {
    return placeRepository.postPlace(place);
  }
}
