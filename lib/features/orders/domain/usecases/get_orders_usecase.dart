import 'package:hungry/core/domain/result.dart';

import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrdersUseCase {
  final OrderRepository _repository;

  GetOrdersUseCase(this._repository);

  Future<Result<List<OrderEntity>>> call() => _repository.getOrders();
}
