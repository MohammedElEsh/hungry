import 'package:dio/dio.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../models/product_model.dart';

class ProductRepo {

  final ApiService apiService = ApiService();


  /// Get all products
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiService.get('/products');
      final data = response['data'];

      return data.map<ProductModel>((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }


  /// Get product by ID
  Future<ProductModel> getProductById(int productId) async {
    try {
      final response = await apiService.get('/products/$productId');

      final data = response['data'];

      return ProductModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
