import 'package:dio/dio.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../models/product_model.dart';
import '../models/side_options_model.dart';
import '../models/topping_model.dart';

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


  ///  Get all toppings
  Future<List<ToppingModel>> getToppings() async {
    try {
      final response = await apiService.get('/toppings');
      final data = response['data'];

      return data
          .map<ToppingModel>((e) => ToppingModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }


  /// Get all side options
  Future<List<SideOptionsModel>> getSideOptions() async {
    try {
      final response = await apiService.get('/side-options');
      final data = response['data'];

      return data
          .map<SideOptionsModel>((e) => SideOptionsModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
