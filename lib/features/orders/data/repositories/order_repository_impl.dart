import '../../../../core/domain/result.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remote;

  OrderRepositoryImpl(this._remote);

  @override
  Future<Result<List<OrderEntity>>> getOrders() async {
    try {
      final models = await _remote.getOrders();
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

  OrderEntity _toEntity(OrderModel m) => OrderEntity(
        id: m.id.toString(),
        status: m.status,
        total: double.tryParse(m.totalPrice.replaceAll(RegExp(r'[^\d.]'), '')) ??
            0.0,
        createdAt: m.createdAt,
        productImage: m.productImage,
      );
}
