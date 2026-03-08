import 'package:hungry/core/domain/result.dart';

import '../../../cart/domain/entities/cart_item_entity.dart';
import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<Result<List<OrderEntity>>> getOrders();
  Future<Result<OrderEntity>> createOrder(List<CartItemEntity> items);
}
