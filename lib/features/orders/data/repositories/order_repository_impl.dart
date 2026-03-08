import '../../../../core/cache/cache_store.dart';
import '../../../../core/domain/result.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final CacheStore _cache;

  OrderRepositoryImpl(this._remote, this._networkInfo, this._cache);

  @override
  Future<Result<List<OrderEntity>>> getOrders() async {
    if (!await _networkInfo.isConnected) {
      final cached = await _cache.getCachedOrders();
      if (cached != null && cached.isNotEmpty) {
        final entities = cached
            .map((m) => OrderModel.fromJson(m))
            .map(_toEntity)
            .toList();
        if (entities.isNotEmpty) return Success(entities);
      }
    }
    try {
      final models = await _remote.getOrders();
      await _cache.setCachedOrders(models.map((m) => m.toJson()).toList());
      final entities = models.map(_toEntity).toList();
      return Success(entities);
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<OrderEntity>> createOrder(List<CartItemEntity> items) async {
    try {
      final model = await _remote.createOrder(items);
      return Success(_toEntity(model));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }

  OrderEntity _toEntity(OrderModel m) => OrderEntity(
        id: m.id.toString(),
        status: m.status,
        total: double.tryParse(m.totalPrice.replaceAll(RegExp(r'[^\d.]'), '')) ??
            0.0,
        createdAt: m.createdAt,
        productImage: m.productImage,
      );
}
