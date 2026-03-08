import 'package:dio/dio.dart';

import '../constants/api_endpoints.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/logging_interceptor.dart';

class DioClient {
  late final Dio _dio;

  DioClient({required AuthInterceptor authInterceptor, String? baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    )..interceptors.addAll([
        authInterceptor,
        LoggingInterceptor(),
      ]);
  }

  Dio get dio => _dio;
}
