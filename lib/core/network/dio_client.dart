import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import 'api_error.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api',
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioError e, handler) {
          if (e.response?.statusCode == 401) {
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> getRequest(String endpoint, BuildContext context) async {
    try {
      return await _dio.get(endpoint);
    } catch (e) {
      if (e is DioError) {
        // ApiExceptions.handleError(e, context);
        ApiExceptions.handleError(e);
      }
      throw ApiError(message: e.toString(), statusCode: 500);
    }
  }


  Dio get dio => _dio;
}
