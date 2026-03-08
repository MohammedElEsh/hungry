import 'package:hungry/core/domain/result.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithGoogleUseCase {
  final AuthRepository _repository;

  LoginWithGoogleUseCase(this._repository);

  Future<Result<UserEntity>> call(String idToken) =>
      _repository.loginWithGoogle(idToken);
}
