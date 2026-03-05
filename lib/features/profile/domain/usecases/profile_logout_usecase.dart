import '../repositories/profile_repository.dart';
import '../result.dart';

class ProfileLogoutUseCase {
  final ProfileRepository _repository;

  ProfileLogoutUseCase(this._repository);

  Future<Result<void>> call() => _repository.logout();
}
