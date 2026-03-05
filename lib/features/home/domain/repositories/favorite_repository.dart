import 'package:hungry/core/domain/result.dart';

abstract class FavoriteRepository {
  Future<Result<List<int>>> getFavorites();
  Future<Result<void>> toggleFavorite(int productId);
}
