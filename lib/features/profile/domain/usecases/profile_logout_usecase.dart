import 'package:hungry/core/domain/result.dart';

import '../repositories/profile_repository.dart';

class ProfileLogoutUseCase {
  final ProfileRepository _repository;

  ProfileLogoutUseCase(this._repository);

  Future<Result<void>> call() => _repository.logout();
}
