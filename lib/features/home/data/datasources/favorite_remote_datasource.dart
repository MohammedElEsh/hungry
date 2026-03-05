import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<int>> getFavorites();
  Future<void> toggleFavorite(int productId);
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final Dio _dio;

  FavoriteRemoteDataSourceImpl(this._dio);

  @override
  Future<List<int>> getFavorites() async {
    try {
      final response = await _dio.get(ApiEndpoints.favorites);
      final raw = response.data;
      if (raw == null) return [];
      List<dynamic> list = [];
      if (raw is List) {
        list = raw;
      } else if (raw is Map) {
        final map = raw;
        if (map['data'] is List) {
          list = map['data'] as List;
        } else if (map['favorites'] is List) {
          list = map['favorites'] as List;
        } else if (map['data'] is Map && (map['data'] as Map)['data'] is List) {
          list = (map['data'] as Map)['data'] as List;
        }
      }
      if (list.isEmpty) return [];
      return list
          .map<int>((e) {
            if (e is int) return e;
            if (e is num) return e.toInt();
            if (e is Map) {
              final m = e;
              final pid = m['product_id'] ?? m['id'] ?? m['productId'] ?? m['product_id'];
              if (pid != null) return (pid is num) ? pid.toInt() : int.tryParse(pid.toString()) ?? 0;
            }
            return 0;
          })
          .where((id) => id > 0)
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthException('Unauthorized');
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('Connection failed');
      }
      if ((e.response?.statusCode ?? 0) >= 400) {
        throw ServerException(
          (e.response?.data is Map &&
                  (e.response?.data as Map)['message'] != null)
              ? (e.response!.data as Map)['message'].toString()
              : 'Server error',
        );
      }
      throw ServerException('Request failed');
    }
  }

  @override
  Future<void> toggleFavorite(int productId) async {
    try {
      await _dio.post(ApiEndpoints.toggleFavorite, data: {'product_id': productId});
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthException('Unauthorized');
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('Connection failed');
      }
      if ((e.response?.statusCode ?? 0) >= 400) {
        throw ServerException(
          (e.response?.data is Map &&
                  (e.response?.data as Map)['message'] != null)
              ? (e.response!.data as Map)['message'].toString()
              : 'Server error',
        );
      }
      throw ServerException('Request failed');
    }
  }
}
