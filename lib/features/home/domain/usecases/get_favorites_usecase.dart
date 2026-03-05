import 'package:hungry/core/domain/result.dart';

import '../repositories/favorite_repository.dart';

class GetFavoritesUseCase {
  final FavoriteRepository _repository;

  GetFavoritesUseCase(this._repository);

  Future<Result<List<int>>> call() => _repository.getFavorites();
}
