import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_respository.dart';
import 'package:places/data/storage/place_storage.dart';

class PlaceInteractor {
  final PlaceRepository placeRepository;
  final PlaceStorage placeStorage;

  final Map<String, double> userCoordinates = {
    'lat': 60.0,
    'lng': 30.0,
  };

  PlaceInteractor({
    required this.placeRepository,
    required this.placeStorage,
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

  List<Place> getFavoritesPlaces() {
    return placeStorage.getFavoritePlaces();
  }

  void addToFavorites(Place place) {
    placeStorage.addToFavorites(place);
  }

  void removeFromFavorites(Place place) {
    placeStorage.removeFromFavorites(place);
  }

  List<Place> getVisitPlaces() {
    return placeStorage.getVisitPlaces();
  }

  void addToVisitingPlaces(Place place) {
    placeStorage.addToVisitingPlaces(place);
  }

  void removeFromVisiting(Place place) {
    placeStorage.removeFromVisiting(place);
  }

  Future<Place?> addNewPlace(Place place) {
    return placeRepository.postPlace(place);
  }
}
