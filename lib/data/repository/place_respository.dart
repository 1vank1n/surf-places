import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/network/api.dart';

class PlaceRepository {
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
}
