import 'package:hungry/core/domain/result.dart';

import '../repositories/profile_repository.dart';

class DeleteAccountUseCase {
  final ProfileRepository _repository;

  DeleteAccountUseCase(this._repository);

  Future<Result<void>> call([String? password]) =>
      _repository.deleteAccount(password);
}
