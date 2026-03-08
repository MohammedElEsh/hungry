import '../../../../core/cache/cache_store.dart';
import '../../../../core/domain/result.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../../../product/data/models/product_model.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final CacheStore _cache;

  ProductRepositoryImpl(this._remote, this._networkInfo, this._cache);

  ProductEntity _toEntity(ProductModel m) => ProductEntity(
        id: m.id?.toString() ?? '',
        name: m.name ?? '',
        price: double.tryParse(m.price ?? '0') ?? 0,
        imageUrl: m.image,
        rating: m.rating,
      );

  @override
  Future<Result<List<ProductEntity>>> getProducts() async {
    if (!await _networkInfo.isConnected) {
      final cached = await _cache.getCachedProducts();
      if (cached != null && cached.isNotEmpty) {
        final entities = cached
            .map((m) => ProductModel.fromJson(m))
            .map(_toEntity)
            .toList();
        if (entities.isNotEmpty) return Success(entities);
      }
      return const FailureResult(NetworkFailure('No connection'));
    }
    try {
      final models = await _remote.getProducts();
      await _cache.setCachedProducts(models.map((m) => m.toJson()).toList());
      return Success(models.map(_toEntity).toList());
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      final cached = await _cache.getCachedProducts();
      if (cached != null && cached.isNotEmpty) {
        final entities = cached
            .map((m) => ProductModel.fromJson(m))
            .map(_toEntity)
            .toList();
        if (entities.isNotEmpty) return Success(entities);
      }
      return FailureResult(NetworkFailure(e.message));
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    }
  }
}
