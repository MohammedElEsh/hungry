import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';

class ApiExceptions {
  // static ApiError handleError(DioError error, BuildContext context) {
  static ApiError handleError(DioError error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        // showErrorBanner(context, "Connection timeout. Please try again later.");
        return ApiError(message: "Connection timeout");

      case DioExceptionType.sendTimeout:
        // showErrorBanner(context, "Request send timeout. Please try again later.");
        return ApiError(message: "Request send timeout");

      case DioExceptionType.receiveTimeout:
        // showErrorBanner(context, "Response receive timeout. Please try again later.");
        return ApiError(message: "Response receive timeout");

      case DioExceptionType.badCertificate:
        // showErrorBanner(context, "Bad SSL certificate. Please check your connection.");
        return ApiError(message: "Bad SSL certificate");

      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 400) {
          // showErrorBanner(context, "Bad request. Invalid parameters.");
          return ApiError(message: "Bad request", statusCode: 400);
        } else if (error.response?.statusCode == 404) {
          // showErrorBanner(context, "Resource not found.");
          return ApiError(message: "Resource not found", statusCode: 404);
        } else if (error.response?.statusCode == 500) {
          // showErrorBanner(context, "Internal server error.");
          return ApiError(message: "Internal server error", statusCode: 500);
        } else {
          // showErrorBanner(context, "Server error. Please try again later.");
          return ApiError(message: "Server error");
        }

      case DioExceptionType.cancel:
        // showWarningBanner(context, "Request was cancelled.");
        return ApiError(message: "Request cancelled");

      case DioExceptionType.connectionError:
        // showErrorBanner(context, "Network connection error. Please check your internet connection.");
        return ApiError(message: "Network connection error");

      case DioExceptionType.unknown:
        // showErrorBanner(context, "An unknown error occurred. Please try again later.");
        return ApiError(message: "Unknown error");

      }
  }
}
