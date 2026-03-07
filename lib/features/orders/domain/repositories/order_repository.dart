import 'package:hungry/core/domain/result.dart';

import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<Result<List<OrderEntity>>> getOrders();
}
