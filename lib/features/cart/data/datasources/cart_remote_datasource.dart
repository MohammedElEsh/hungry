import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../models/cart_item_model.dart';

/// Cart API response: items + optional total_price from API.
class CartResponse {
  final List<CartItemModel> items;
  final String? totalPrice;

  const CartResponse({required this.items, this.totalPrice});
}

abstract class CartRemoteDataSource {
  Future<CartResponse> getCart();
  Future<void> addToCart(CartItemEntity item);
  Future<void> removeFromCart(String itemId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final Dio _dio;

  CartRemoteDataSourceImpl(this._dio);

  static List<dynamic> _extractList(dynamic raw) {
    if (raw == null) return [];
    if (raw is List) return raw;
    if (raw is! Map) return [];
    final map = Map<String, dynamic>.from(raw);
    for (final key in ['data', 'cart', 'items', 'products']) {
      final v = map[key];
      if (v is List) return v;
    }
    final data = map['data'];
    if (data is Map) {
      final inner = Map<String, dynamic>.from(data);
      for (final key in ['data', 'cart', 'items', 'products']) {
        final v = inner[key];
        if (v is List) return v;
      }
    }
    return [];
  }

  static String? _extractTotal(dynamic raw) {
    if (raw == null || raw is! Map) return null;
    final map = Map<String, dynamic>.from(raw);
    for (final key in ['total_price', 'totalPrice', 'total']) {
      final v = map[key];
      if (v != null) return v is String ? v : v.toString();
    }
    final data = map['data'];
    if (data is Map) {
      final inner = Map<String, dynamic>.from(data);
      for (final key in ['total_price', 'totalPrice', 'total']) {
        final v = inner[key];
        if (v != null) return v is String ? v : v.toString();
      }
    }
    return null;
  }

  @override
  Future<CartResponse> getCart() async {
    try {
      final response = await _dio.get(ApiEndpoints.cart);
      final list = _extractList(response.data);
      final totalPrice = _extractTotal(response.data);
      final results = <CartItemModel>[];
      for (final e in list) {
        if (e is! Map) continue;
        try {
          results.add(CartItemModel.fromJson(Map<String, dynamic>.from(e)));
        } catch (e) {
          AppLogger.w('Cart item parse failed: $e');
        }
      }
      return CartResponse(items: results, totalPrice: totalPrice);
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
      rethrow;
    }
  }

  @override
  Future<void> addToCart(CartItemEntity item) async {
    try {
      final itemPayload = <String, dynamic>{
        'product_id': item.productId,
        'quantity': item.quantity,
      };
      if (item.toppingIds.isNotEmpty) {
        itemPayload['toppings'] = item.toppingIds;
      }
      if (item.sideOptionIds.isNotEmpty) {
        itemPayload['side_options'] = item.sideOptionIds;
      }
      if (item.spicy > 0) itemPayload['spicy'] = item.spicy;
      if (item.image != null && item.image!.isNotEmpty) itemPayload['image'] = item.image;
      await _dio.post(
        ApiEndpoints.cartAdd,
        data: {'items': [itemPayload]},
      );
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
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart(String itemId) async {
    try {
      await _dio.delete(ApiEndpoints.cartRemove(itemId));
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
      rethrow;
    }
  }
}
