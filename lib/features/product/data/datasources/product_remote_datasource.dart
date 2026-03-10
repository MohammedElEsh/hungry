import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/logger/app_logger.dart';
import '../models/product_model.dart';
import '../models/side_options_model.dart';
import '../models/topping_model.dart';

abstract class ProductDetailRemoteDataSource {
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getAllProducts();
  Future<List<ToppingModel>> getToppings();
  Future<List<SideOptionsModel>> getSideOptions(String productId);
}

class ProductDetailRemoteDataSourceImpl implements ProductDetailRemoteDataSource {
  final Dio _dio;

  ProductDetailRemoteDataSourceImpl(this._dio);

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await _dio.get(ApiEndpoints.productById(id));
      final data = response.data;
      if (data == null) throw ServerException('Empty product response');
      Map<String, dynamic>? productMap;
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        final raw = map['data'] ?? map['product'];
        if (raw is Map) {
          productMap = Map<String, dynamic>.from(raw);
        } else if (raw is List && raw.isNotEmpty && raw.first is Map) {
          productMap = Map<String, dynamic>.from(raw.first as Map);
        } else {
          productMap = map;
        }
      } else if (data is List && data.isNotEmpty && data.first is Map) {
        productMap = Map<String, dynamic>.from(data.first as Map);
      }
      if (productMap == null || productMap.isEmpty) {
        throw ServerException('Invalid product response');
      }
      return ProductModel.fromJson(productMap);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('Connection failed');
      }
      if (e.response?.statusCode == 401) throw AuthException('Unauthorized');
      if ((e.response?.statusCode ?? 0) >= 400) {
        final msg = (e.response?.data is Map && (e.response!.data as Map)['message'] != null)
            ? (e.response!.data as Map)['message'].toString()
            : 'Server error';
        throw ServerException(msg, statusCode: e.response?.statusCode);
      }
      throw ServerException('Request failed');
    }
  }

  static List<dynamic> _extractProductList(dynamic raw) {
    if (raw == null) return [];
    if (raw is List) return raw;
    if (raw is! Map) return [];
    final map = raw;
    for (final key in ['data', 'products', 'results', 'items']) {
      final v = map[key];
      if (v is List) return v;
    }
    final data = map['data'];
    if (data is Map) {
      for (final key in ['data', 'products', 'results', 'items']) {
        final v = data[key];
        if (v is List) return v;
      }
    }
    return [];
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await _dio.get(ApiEndpoints.products);
      final list = _extractProductList(response.data);
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
    } on DioException catch (_) {
      return [];
    }
  }

  @override
  Future<List<ToppingModel>> getToppings() async {
    try {
      final response = await _dio.get(ApiEndpoints.toppings);
      final data = response.data;
      if (data == null) return [];
      List<dynamic> list = [];
      if (data is List) {
        list = data;
      } else if (data is Map<String, dynamic>) {
        final raw = data['data'] ?? data['toppings'] ?? data['items'] ?? data['results'];
        if (raw is List) list = raw;
      }
      if (list.isEmpty) return [];
      final results = <ToppingModel>[];
      for (final e in list) {
        if (e is! Map) continue;
        try {
          results.add(ToppingModel.fromJson(Map<String, dynamic>.from(e)));
        } catch (e) {
          AppLogger.w('Topping item parse failed: $e');
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
      if (e.response?.statusCode == 401) throw AuthException('Unauthorized');
      if ((e.response?.statusCode ?? 0) >= 400) {
        final msg = (e.response?.data is Map && (e.response!.data as Map)['message'] != null)
            ? (e.response!.data as Map)['message'].toString()
            : 'Server error';
        throw ServerException(msg, statusCode: e.response?.statusCode);
      }
      throw ServerException('Request failed');
    }
  }

  @override
  Future<List<SideOptionsModel>> getSideOptions(String productId) async {
    try {
      final response = await _dio.get(ApiEndpoints.sideOptions);
      final data = response.data;
      if (data == null) return [];
      List<dynamic> list = [];
      if (data is List) {
        list = data;
      } else if (data is Map<String, dynamic>) {
        final raw = data['data'] ?? data['side_options'] ?? data['sideOptions'] ?? data['items'] ?? data['results'];
        if (raw is List) list = raw;
      }
      if (list.isEmpty) return [];
      final results = <SideOptionsModel>[];
      for (final e in list) {
        if (e is! Map) continue;
        try {
          results.add(SideOptionsModel.fromJson(Map<String, dynamic>.from(e)));
        } catch (e) {
          AppLogger.w('Side option item parse failed: $e');
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
      if (e.response?.statusCode == 401) throw AuthException('Unauthorized');
      if ((e.response?.statusCode ?? 0) >= 400) {
        final msg = (e.response?.data is Map && (e.response!.data as Map)['message'] != null)
            ? (e.response!.data as Map)['message'].toString()
            : 'Server error';
        throw ServerException(msg, statusCode: e.response?.statusCode);
      }
      throw ServerException('Request failed');
    }
  }
}
