import 'package:dio/dio.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../models/category_model.dart';

class CategoryRepo {
  final ApiService _apiService = ApiService();

  /// GET /categories - Get all categories
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _apiService.get('/categories');
      final data = response['data'];
      if (data == null || data is! List) return [];
      return data
          .map<CategoryModel>(
            (e) => CategoryModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
