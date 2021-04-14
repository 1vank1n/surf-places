import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_respository.dart';

class PlaceInteractor {
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

  // List<Place> getFavoritesPlaces() {}

  // void addToFavorites(Place place) {}

  // void removeFromFavorites(Place place) {}

  // List<Place> getVisitPlaces() {}

  // void addToVisitingPlaces(Place place) {}

  // void addNewPlace(Place place) {}
}
