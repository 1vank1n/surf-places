import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/network/api.dart';

class ApiRoutes {
  static const places = '/place';
  static const filteredPlaces = '/filtered_places';
}

class ApiDio implements Api {
  late Dio _client;

  ApiDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://test-backend-flutter.surfstudio.ru',
        connectTimeout: 5000,
        receiveTimeout: 5000,
        sendTimeout: 5000,
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioError err, ErrorInterceptorHandler handler) {
          print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
          return handler.next(err);
        },
      ),
    );

    _client = dio;
  }

  Future<List<Place>> getPlaces() async {
    List<Place> places = [];

    try {
      Response response = await _client.get(ApiRoutes.places);
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

  Future<Place?> getPlace(int id) async {
    Place? place;

    try {
      final String url = '${ApiRoutes.places}/$id';
      Response response = await _client.get(url);
      final raw = response.data as Map<String, dynamic>;
      place = Place.fromJson(raw);
    } catch (err) {
      print('Get place error: $err');
    }

    return place;
  }

  Future<Place?> postPlace(Place place) async {
    Place? newPlace;

    try {
      Map<String, dynamic> data = place.json;
      data.remove('id');
      Response response = await _client.post(ApiRoutes.places, data: data);
      final raw = response.data as Map<String, dynamic>;
      newPlace = Place.fromJson(raw);
    } catch (err) {
      print('Post place error: $err');
    }

    return newPlace;
  }

  Future<Place?> putPlace(Place place) async {
    Place? updatedPlace;

    try {
      final url = '${ApiRoutes.places}/${place.id}';
      Response response = await _client.put(url, data: place.json);
      final raw = response.data as Map<String, dynamic>;
      updatedPlace = Place.fromJson(raw);
    } catch (err) {
      print('Put place error: $err');
    }

    return updatedPlace;
  }

  Future<bool> deletePlace(int id) async {
    bool result = false;

    try {
      final url = '${ApiRoutes.places}/$id';
      Response response = await _client.delete(url);
      result = response.statusCode == 200;
    } catch (err) {
      print('Delete place error: $err');
    }

    return result;
  }

  Future<List<Place>> postFilteredPlaces(PlacesFilterRequestDto placesFilter) async {
    List<Place> places = [];

    try {
      Response response = await _client.post(ApiRoutes.filteredPlaces, data: placesFilter.json);
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
