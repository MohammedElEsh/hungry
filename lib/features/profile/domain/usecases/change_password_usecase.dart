import 'package:hungry/core/domain/result.dart';

import '../repositories/profile_repository.dart';

class ChangePasswordUseCase {
  final ProfileRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<Result<void>> call(String currentPassword, String newPassword) =>
      _repository.changePassword(currentPassword, newPassword);
}
