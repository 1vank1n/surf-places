import 'package:dio/dio.dart';

class Api {
  static final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://test-backend-flutter.surfstudio.ru',
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
      responseType: ResponseType.json,
    ),
  );

  static Dio _addInterceptors(Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          print('REQUEST DATA: ${options.data}');
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
    return dio;
  }

  static final client = _addInterceptors(_dio);
}
