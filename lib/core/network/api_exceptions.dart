import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hungry/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final data = error.response?.data;
    final statusCode = error.response?.statusCode;

    if (statusCode != null) {
      if (data is Map<String, dynamic> && data['message'] != null) {
        return ApiError(message: data['message'], statusCode: statusCode);
      }
    }

    if (statusCode == 302) {
      throw ApiError(message: "this Email already exist");
    }

    if (kDebugMode) {
      print(statusCode);
    }
    if (kDebugMode) {
      print(data);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection timeout. Please try again later.");

      case DioExceptionType.sendTimeout:
        return ApiError(message: "Request send timeout. Please try again.");

      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Response receive timeout. Please try again.");

      case DioExceptionType.badCertificate:
        return ApiError(
          message: "Bad SSL certificate. Please check your network.",
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final serverMessage = error.response?.data?['message'];

        if (statusCode == 400) {
          return ApiError(
            message: serverMessage ?? "Bad request",
            statusCode: 400,
          );
        } else if (statusCode == 401) {
          return ApiError(
            message: serverMessage ?? "Unauthorized",
            statusCode: 401,
          );
        } else if (statusCode == 404) {
          return ApiError(
            message: serverMessage ?? "Resource not found",
            statusCode: 404,
          );
        } else if (statusCode == 500) {
          return ApiError(
            message: serverMessage ?? "Internal server error",
            statusCode: 500,
          );
        } else {
          return ApiError(
            message: serverMessage ?? "Unexpected server error",
            statusCode: statusCode,
          );
        }

      case DioExceptionType.cancel:
        return ApiError(message: "Request was cancelled.");

      case DioExceptionType.connectionError:
        return ApiError(
          message: "Network connection error. Please check your internet.",
        );

      case DioExceptionType.unknown:
        return ApiError(
          message: "An unknown error occurred. Please try again later.",
        );
    }
  }
}
