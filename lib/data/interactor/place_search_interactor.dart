import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/network/api.dart';
import 'package:places/data/network/api_dio.dart';
import 'package:places/data/repository/place_respository.dart';

class PlaceSearchInteractor {
  late final PlaceRepository placeRepository;
  final List<String> queries = [];

  PlaceSearchInteractor() {
    Api api = ApiDio();
    placeRepository = PlaceRepository(api: api);
  }

  Future<List<Place>> searchPlaces(String name) {
    var _filter = PlacesFilterRequestDto(nameFilter: name);
    addQuery(name);
    return placeRepository.postFilteredPlaces(_filter);
  }

  void addQuery(String query) {
    if (query != '') {
      if (!queries.contains(query)) {
        queries.add(query);
      } else {
        queries.remove(query);
        queries.insert(0, query);
      }
    }
  }

  void removeQuery(String query) {
    if (queries.contains(query)) {
      queries.remove(query);
    }
  }

  void cleanQueries() {
    queries.clear();
  }
}
