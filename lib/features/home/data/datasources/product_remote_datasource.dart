import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio _dio;

  ProductRemoteDataSourceImpl(this._dio);

  static List<dynamic> _extractList(dynamic raw) {
    if (raw == null) return [];
    if (raw is List) return raw;
    if (raw is! Map) return [];
    final map = Map<String, dynamic>.from(raw);
    for (final key in ['data', 'products', 'results', 'items']) {
      final v = map[key];
      if (v is List) return v;
    }
    final data = map['data'];
    if (data is Map) {
      final inner = Map<String, dynamic>.from(data);
      for (final key in ['data', 'products', 'results', 'items']) {
        final v = inner[key];
        if (v is List) return v;
      }
    }
    return [];
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get(ApiEndpoints.products);
      final list = _extractList(response.data);
      if (list.isEmpty) return [];
      final results = <ProductModel>[];
      for (final e in list) {
        if (e is! Map) continue;
        try {
          results.add(ProductModel.fromJson(Map<String, dynamic>.from(e)));
        } catch (e) {
          AppLogger.w('Product item parse failed: $e');
        }
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
          (e.response?.data is Map &&
                  (e.response?.data as Map)['message'] != null)
              ? (e.response!.data as Map)['message'].toString()
              : 'Server error',
          statusCode: e.response?.statusCode,
        );
      }
      throw ServerException('Request failed');
    }
  }
}
