import '../../../../core/cache/cache_store.dart';
import '../../../../core/domain/result.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_datasource.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final CacheStore _cache;

  CategoryRepositoryImpl(this._remote, this._networkInfo, this._cache);

  @override
  Future<Result<List<CategoryEntity>>> getCategories() async {
    if (!await _networkInfo.isConnected) {
      final cached = await _cache.getCachedCategories();
      if (cached != null && cached.isNotEmpty) {
        final entities = cached
            .map((m) => CategoryModel.fromJson(m))
            .where((m) => m.name.isNotEmpty)
            .map((m) => CategoryEntity(id: m.id, name: m.name))
            .toList();
        if (entities.isNotEmpty) return Success(entities);
      }
      return const FailureResult(NetworkFailure('No connection'));
    }
    try {
      final models = await _remote.getCategories();
      await _cache.setCachedCategories(models.map((m) => m.toJson()).toList());
      return Success(models.map((m) => CategoryEntity(id: m.id, name: m.name)).toList());
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      final cached = await _cache.getCachedCategories();
      if (cached != null && cached.isNotEmpty) {
        final entities = cached
            .map((m) => CategoryModel.fromJson(m))
            .where((m) => m.name.isNotEmpty)
            .map((m) => CategoryEntity(id: m.id, name: m.name))
            .toList();
        if (entities.isNotEmpty) return Success(entities);
      }
      return FailureResult(NetworkFailure(e.message));
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    }
  }
}
