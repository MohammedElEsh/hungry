import 'package:hungry/core/domain/result.dart';

import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository _repository;

  RemoveFromCartUseCase(this._repository);

  Future<Result<void>> call(String itemId) =>
      _repository.removeFromCart(itemId);
}
