import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: "Unexpected error: ${e.toString()}");
    }
  }

  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(
        endPoint,
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: "Unexpected error: ${e.toString()}");
    }
  }

  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.put(
        endPoint,
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: "Unexpected error: ${e.toString()}");
    }
  }

  Future<dynamic> delete(String endPoint, [Map<String, dynamic>? body]) async {
    try {
      final response = await _dioClient.dio.delete(
        endPoint,
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: "Unexpected error: ${e.toString()}");
    }
  }
}
