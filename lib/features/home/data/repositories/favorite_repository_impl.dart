import '../../../../core/domain/result.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_remote_datasource.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource _remote;

  FavoriteRepositoryImpl(this._remote);

  @override
  Future<Result<List<int>>> getFavorites() async {
    try {
      final ids = await _remote.getFavorites();
      return Success(ids);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    }
  }

  @override
  Future<Result<void>> toggleFavorite(int productId) async {
    try {
      await _remote.toggleFavorite(productId);
      return const Success(null);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    }
  }
}
