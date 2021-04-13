import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/network/api.dart';

class PlaceRepository {
  static const route = '/place';
  static const filteredRoute = '/filtered_places';

  static Future<List<Place>> getPlaces() async {
    List<Place> places = [];

    try {
      Response response = await Api.client.get(route);
      final rawList = response.data as List;
      for (var raw in rawList) {
        try {
          places.add(Place.fromJson(raw));
        } catch (err) {
          print('Skip place parsing. Error: $err, data: $raw');
        }
      }
      places = rawList.map((raw) => Place.fromJson(raw)).toList();
    } catch (err) {
      print('Get places error: $err');
    }

    return places;
  }

  static Future<Place?> getPlace(int id) async {
    Place? place;

    try {
      final String url = '$route/$id';
      Response response = await Api.client.get(url);
      final raw = response.data as Map<String, dynamic>;
      place = Place.fromJson(raw);
    } catch (err) {
      print('Get place error: $err');
    }

    return place;
  }

  static Future<Place?> postPlace(Place place) async {
    Place? newPlace;

    try {
      Response response = await Api.client.post(route, data: place.json);
      final raw = response.data as Map<String, dynamic>;
      newPlace = Place.fromJson(raw);
    } catch (err) {
      print('Post place error: $err');
    }

    return newPlace;
  }

  static Future<Place?> putPlace(Place place) async {
    Place? updatedPlace;

    try {
      final url = '$route/${place.id}';
      Response response = await Api.client.put(url, data: place.json);
      final raw = response.data as Map<String, dynamic>;
      updatedPlace = Place.fromJson(raw);
    } catch (err) {
      print('Put place error: $err');
    }

    return updatedPlace;
  }

  static Future<bool> deletePlace(int id) async {
    bool result = false;

    try {
      final url = '$route/$id';
      Response response = await Api.client.delete(url);
      result = response.statusCode == 200;
    } catch (err) {
      print('Delete place error: $err');
    }

    return result;
  }

  static Future<List<Place>> postFilteredPlaces(PlacesFilterRequestDto placesFilter) async {
    List<Place> places = [];

    try {
      Response response = await Api.client.post(filteredRoute, data: placesFilter.json);
      final rawList = response.data as List;
      for (var raw in rawList) {
        try {
          places.add(Place.fromJson(raw));
        } catch (err) {
          print('Skip place parsing. Error: $err, data: $raw');
        }
      }
      places = rawList.map((raw) => Place.fromJson(raw)).toList();
    } catch (err) {
      print('Get post filtered places error: $err');
    }

    return places;
  }
}
