import '../entities/order_entity.dart';
import '../result.dart';

abstract class OrderRepository {
  Future<Result<List<OrderEntity>>> getOrders();
}
