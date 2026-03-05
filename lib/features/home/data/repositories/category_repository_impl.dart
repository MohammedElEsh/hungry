import '../../../../core/domain/result.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_datasource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _remote;
  final NetworkInfo _networkInfo;

  CategoryRepositoryImpl(this._remote, this._networkInfo);

  @override
  Future<Result<List<CategoryEntity>>> getCategories() async {
    if (!await _networkInfo.isConnected) {
      return const FailureResult(NetworkFailure('No connection'));
    }
    try {
      final models = await _remote.getCategories();
      return Success(models.map((m) => CategoryEntity(id: m.id, name: m.name)).toList());
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    }
  }
}
