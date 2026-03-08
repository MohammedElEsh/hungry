import 'package:hungry/core/domain/result.dart';

import '../repositories/auth_repository.dart';

class ResetPasswordWithOtpUseCase {
  final AuthRepository _repository;

  ResetPasswordWithOtpUseCase(this._repository);

  Future<Result<void>> call(String email, String otp, String newPassword) =>
      _repository.resetPasswordWithOtp(email, otp, newPassword);
}
