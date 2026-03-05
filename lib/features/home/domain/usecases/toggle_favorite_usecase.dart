import 'package:hungry/core/domain/result.dart';

import '../repositories/favorite_repository.dart';

class ToggleFavoriteUseCase {
  final FavoriteRepository _repository;

  ToggleFavoriteUseCase(this._repository);

  Future<Result<void>> call(int productId) =>
      _repository.toggleFavorite(productId);
}
