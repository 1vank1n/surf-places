import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';

abstract class Api {
  Future<List<Place>> getPlaces();
  Future<Place?> getPlace(int id);
  Future<Place?> postPlace(Place place);
  Future<Place?> putPlace(Place place);
  Future<bool> deletePlace(int id);
  Future<List<Place>> postFilteredPlaces(PlacesFilterRequestDto placesFilter);
}
