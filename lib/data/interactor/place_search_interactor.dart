import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_respository.dart';

class PlaceSearchInteractor {
  static List<String> queries = [];

  Future<List<Place>> searchPlaces(String name) {
    var _filter = PlacesFilterRequestDto(nameFilter: name);
    addQuery(name);
    return PlaceRepository().postFilteredPlaces(_filter);
  }

  static void addQuery(String query) {
    if (query != '') {
      if (!queries.contains(query)) {
        queries.add(query);
      } else {
        queries.remove(query);
        queries.insert(0, query);
      }
    }
  }

  static void removeQuery(String query) {
    if (queries.contains(query)) {
      queries.remove(query);
    }
  }

  static void cleanQueries() {
    queries.clear();
  }
}
