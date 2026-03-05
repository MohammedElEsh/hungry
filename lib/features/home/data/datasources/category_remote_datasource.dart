import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio _dio;

  CategoryRemoteDataSourceImpl(this._dio);

  static List<dynamic> _extractList(dynamic raw) {
    if (raw == null) return [];
    if (raw is List) return raw;
    if (raw is! Map) return [];
    final map = Map<String, dynamic>.from(raw);
    for (final key in ['data', 'categories', 'results', 'items']) {
      final v = map[key];
      if (v is List) return v;
    }
    final data = map['data'];
    if (data is Map) {
      final inner = Map<String, dynamic>.from(data);
      for (final key in ['data', 'categories', 'results', 'items']) {
        final v = inner[key];
        if (v is List) return v;
      }
    }
    return [];
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get(ApiEndpoints.categories);
      final list = _extractList(response.data);
      if (list.isEmpty) return [];
      final results = <CategoryModel>[];
      for (final e in list) {
        if (e is! Map) continue;
        try {
          final model = CategoryModel.fromJson(Map<String, dynamic>.from(e));
          if (model.name.isNotEmpty) results.add(model);
        } catch (_) {}
      }
      return results;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('Connection failed');
      }
      if (e.response?.statusCode == 401) {
        throw AuthException('Unauthorized');
      }
      if ((e.response?.statusCode ?? 0) >= 400) {
        throw ServerException(
          (e.response?.data is Map && (e.response?.data as Map)['message'] != null)
              ? (e.response!.data as Map)['message'].toString()
              : 'Server error',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException('Request failed');
    }
  }
}
