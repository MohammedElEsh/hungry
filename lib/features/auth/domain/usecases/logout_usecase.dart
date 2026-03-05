import 'package:hungry/core/domain/result.dart';

import '../repositories/auth_repository.dart';

/// Logout use case.
class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Result<void>> call() => _repository.logout();
}
