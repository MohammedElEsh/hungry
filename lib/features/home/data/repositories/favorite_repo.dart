import 'package:dio/dio.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_service.dart';

class FavoriteRepo {
  final ApiService _apiService = ApiService();

  /// GET /favorites - Get user favorite product IDs
  Future<List<int>> getFavorites() async {
    try {
      final response = await _apiService.get('/favorites');
      final data = response['data'];
      if (data == null) return [];
      if (data is List) {
        return data
            .map<int>((e) {
              if (e is int) return e;
              if (e is Map && e['product_id'] != null) {
                return (e['product_id'] as num).toInt();
              }
              if (e is Map && e['id'] != null) {
                return (e['id'] as num).toInt();
              }
              return (e as num?)?.toInt() ?? 0;
            })
            .where((id) => id > 0)
            .toList();
      }
      return [];
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// POST /toggle-favorite - Toggle favorite for product
  Future<void> toggleFavorite(int productId) async {
    try {
      await _apiService.post('/toggle-favorite', {'product_id': productId});
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
