import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/network/exceptions.dart';

abstract class Api {
  Future<List<Place>> getPlaces();
  Future<Place?> getPlace(int id);
  Future<Place?> postPlace(Place place);
  Future<Place?> putPlace(Place place);
  Future<bool> deletePlace(int id);
  Future<List<Place>> postFilteredPlaces(PlacesFilterRequestDto placesFilter);
}

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

          throw NetworkException(
            path: err.requestOptions.path,
            statusCode: err.response?.statusCode ?? 0,
            message: err.response?.statusMessage ?? 'Unknown network error',
          );
        },
      ),
    );

    _client = dio;
  }

  Future<List<Place>> getPlaces() async {
    List<Place> places = [];

    Response<List> response = await _client.get(ApiRoutes.places);
    final rawList = response.data ?? [];
    for (var raw in rawList) {
      try {
        places.add(Place.fromJson(raw));
      } on TypeError catch (err) {
        print('Skip place parsing. Error: $err, data: $raw');
      }
    }

    return places;
  }

  Future<Place?> getPlace(int id) async {
    Place? place;

    final String url = '${ApiRoutes.places}/$id';
    Response<Map<String, dynamic>> response = await _client.get(url);

    try {
      place = Place.fromJson(response.data!);
    } on TypeError catch (err) {
      print('Get place error: $err');
    }

    return place;
  }

  Future<Place?> postPlace(Place place) async {
    // TODO temp disable
    // Place? newPlace;

    // Map<String, dynamic> data = place.json;
    // data.remove('id');
    // Response<Map<String, dynamic>> response = await _client.post(
    //   ApiRoutes.places,
    //   data: data,
    // );

    // try {
    //   newPlace = Place.fromJson(response.data!);
    // } on TypeError catch (err) {
    //   print('Post place error: $err');
    // }

    return Future.delayed(Duration(seconds: 1), () => place);
  }

  Future<Place?> putPlace(Place place) async {
    Place? updatedPlace;

    final url = '${ApiRoutes.places}/${place.id}';
    final Response<Map<String, dynamic>> response = await _client.put(
      url,
      data: place.toJson(),
    );

    try {
      updatedPlace = Place.fromJson(response.data!);
    } on TypeError catch (err) {
      print('Put place error: $err');
    }

    return updatedPlace;
  }

  Future<bool> deletePlace(int id) async {
    final url = '${ApiRoutes.places}/$id';
    final Response response = await _client.delete(url);
    return response.statusCode == 200;
  }

  Future<List<Place>> postFilteredPlaces(PlacesFilterRequestDto placesFilter) async {
    List<Place> places = [];

    final Response<List> response = await _client.post(
      ApiRoutes.filteredPlaces,
      data: placesFilter.toJson(),
    );

    final rawList = response.data ?? [];
    for (var raw in rawList) {
      try {
        places.add(Place.fromJson(raw));
      } on TypeError catch (err) {
        print('Skip place parsing. Error: $err, data: $raw');
      }
    }

    return places;
  }
}
