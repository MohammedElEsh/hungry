import 'package:hungry/core/domain/result.dart';

import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository _repository;

  AddToCartUseCase(this._repository);

  Future<Result<void>> call(CartItemEntity item) => _repository.addToCart(item);
}
