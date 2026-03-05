import 'package:hungry/core/domain/result.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Result<UserEntity>> call(
      String email, String password, String name) {
    return _repository.register(email, password, name);
  }
}
