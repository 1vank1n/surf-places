class NetworkException implements Exception {
  final String path;
  final int statusCode;
  final String message;

  NetworkException({
    required this.path,
    required this.statusCode,
    required this.message,
  });

  @override
  String toString() {
    return 'В запросе $path возникла ошибка: $statusCode $message';
  }
}
