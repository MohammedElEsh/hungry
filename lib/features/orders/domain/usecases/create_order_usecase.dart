import 'package:hungry/core/domain/result.dart';

import '../../../cart/domain/entities/cart_item_entity.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class CreateOrderUseCase {
  CreateOrderUseCase(this._repository);

  final OrderRepository _repository;

  Future<Result<OrderEntity>> call(List<CartItemEntity> items) =>
      _repository.createOrder(items);
}
