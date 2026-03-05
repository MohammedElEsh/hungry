import 'package:hungry/core/domain/result.dart';

import '../repositories/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository _repository;

  ClearCartUseCase(this._repository);

  Future<Result<void>> call() => _repository.clearCart();
}
