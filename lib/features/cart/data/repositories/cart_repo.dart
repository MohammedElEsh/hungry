import 'package:dio/dio.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../models/cart_model.dart';

class CartRepo {
  final ApiService apiService = ApiService();

  Map<String, dynamic> _extractCartData(dynamic response) {
    if (response == null) return {'items': []};
    if (response is! Map<String, dynamic>) return {'items': []};
    final data = response['data'];
    if (data != null && data is Map<String, dynamic>) return data;
    if (response['items'] != null) return response;
    return {'items': []};
  }

  /// Get current cart
  Future<CartModel> getCart() async {
    try {
      final response = await apiService.get('/cart');
      return CartModel.fromJson(_extractCartData(response));
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Add items to cart
  /// POST /cart/add
  /// Body: { "items": [{ "product_id", "quantity", "spicy", "toppings", "side_options" }] }
  Future<CartModel> addToCart(List<CartItem> items) async {
    try {
      final response = await apiService.post('/cart/add', {
        'items': items.map((e) => e.toJson()).toList(),
      });
      return CartModel.fromJson(_extractCartData(response));
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Remove item from cart by item ID
  /// DELETE /cart/remove/:id
  Future<void> removeCartItem(int itemId) async {
    try {
      await apiService.delete('/cart/remove/$itemId');
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
