import 'package:hungry/core/domain/result.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithAppleUseCase {
  final AuthRepository _repository;

  LoginWithAppleUseCase(this._repository);

  Future<Result<UserEntity>> call(String idToken) =>
      _repository.loginWithApple(idToken);
}
