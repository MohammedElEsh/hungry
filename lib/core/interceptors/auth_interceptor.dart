import 'package:dio/dio.dart';

/// Interceptor that adds auth token to requests.
class AuthInterceptor extends Interceptor {
  // Token should be injected via GetIt or similar
  String? _token;

  void setToken(String? token) {
    _token = token;
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (_token != null && _token!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $_token';
    }
    handler.next(options);
  }
}
