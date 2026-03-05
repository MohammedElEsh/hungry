import 'package:hungry/core/domain/result.dart';

import '../entities/cart_data.dart';
import '../repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository _repository;

  GetCartItemsUseCase(this._repository);

  Future<Result<CartData>> call() => _repository.getCartItems();
}
