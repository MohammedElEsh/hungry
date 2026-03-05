import 'package:dio/dio.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../models/order_model.dart';

class OrderRepo {
  final ApiService _apiService = ApiService();

  List<OrderModel> _parseOrdersList(dynamic response) {
    if (response == null) return [];
    if (response is! Map<String, dynamic>) return [];
    final data = response['data'];
    if (data == null || data is! List) return [];
    return data
        .map<OrderModel>(
          (e) => OrderModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await _apiService.get('/orders');
      return _parseOrdersList(response);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> getOrderById(int id) async {
    try {
      final response = await _apiService.get('/orders/$id');
      if (response is Map<String, dynamic> && response['data'] != null) {
        return response['data'] as Map<String, dynamic>;
      }
      return {};
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<void> createOrder(List<CartItemEntity> cartItems) async {
    if (cartItems.isEmpty) {
      throw ApiError(message: 'Cart is empty');
    }
    try {
      final items = cartItems
          .map((item) => {
                'product_id': int.tryParse(item.productId) ?? 0,
                'quantity': item.quantity,
              })
          .toList();
      await _apiService.post('/orders', {'items': items});
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError(message: e.toString());
    }
  }
}
