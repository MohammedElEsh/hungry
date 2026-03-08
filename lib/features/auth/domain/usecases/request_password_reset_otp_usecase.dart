import 'package:hungry/core/domain/result.dart';

import '../repositories/auth_repository.dart';

class RequestPasswordResetOtpUseCase {
  final AuthRepository _repository;

  RequestPasswordResetOtpUseCase(this._repository);

  Future<Result<void>> call(String email) =>
      _repository.requestPasswordResetOtp(email);
}
