import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> createOrder(List<CartItemEntity> items);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio _dio;

  OrderRemoteDataSourceImpl(this._dio);

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await _dio.get(ApiEndpoints.orders);
      final raw = response.data;
      if (raw == null) return [];
      if (raw is List) {
        return raw
            .map<OrderModel>(
                (e) => OrderModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      if (raw is! Map<String, dynamic>) return [];
      final list = raw['data'];
      if (list == null) return [];
      if (list is! List) return [];
      return list
          .map<OrderModel>(
              (e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('Connection failed');
      }
      if (e.response?.statusCode == 401) throw AuthException('Unauthorized');
      if ((e.response?.statusCode ?? 0) >= 400) {
        final msg = (e.response?.data is Map &&
                (e.response!.data as Map)['message'] != null)
            ? (e.response!.data as Map)['message'].toString()
            : 'Server error';
        throw ServerException(msg, statusCode: e.response?.statusCode);
      }
      throw ServerException('Request failed');
    }
  }

  @override
  Future<OrderModel> createOrder(List<CartItemEntity> items) async {
    if (items.isEmpty) {
      throw ServerException('Cart is empty');
    }
    try {
      final body = {
        'items': items
            .map((e) => {
                  'product_id': int.tryParse(e.productId) ?? 0,
                  'quantity': e.quantity,
                })
            .toList(),
      };
      final response = await _dio.post(ApiEndpoints.orders, data: body);
      final raw = response.data;
      if (raw is Map<String, dynamic>) {
        final data = raw['data'];
        if (data is Map<String, dynamic>) {
          return OrderModel.fromJson(data);
        }
        return OrderModel.fromJson(raw);
      }
      return OrderModel(
        id: 0,
        status: 'pending',
        totalPrice: '0',
        createdAt: DateTime.now().toIso8601String(),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('Connection failed');
      }
      if (e.response?.statusCode == 401) throw AuthException('Unauthorized');
      if ((e.response?.statusCode ?? 0) >= 400) {
        final msg = (e.response?.data is Map &&
                (e.response!.data as Map)['message'] != null)
            ? (e.response!.data as Map)['message'].toString()
            : 'Server error';
        throw ServerException(msg, statusCode: e.response?.statusCode);
      }
      throw ServerException('Request failed');
    }
  }
}
