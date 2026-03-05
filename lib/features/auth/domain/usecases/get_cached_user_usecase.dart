import 'package:hungry/core/domain/result.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Get cached user use case.
class GetCachedUserUseCase {
  final AuthRepository _repository;

  GetCachedUserUseCase(this._repository);

  Future<Result<UserEntity?>> call() => _repository.getCachedUser();
}
