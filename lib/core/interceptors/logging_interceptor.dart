import 'package:dio/dio.dart';
import '../logger/app_logger.dart';

/// Interceptor for logging HTTP requests and responses.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.d('HTTP Request: ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    AppLogger.d('HTTP Response: ${response.statusCode}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e('HTTP Error: ${err.message}', err);
    handler.next(err);
  }
}
