import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';
import '../result.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Result<ProfileEntity?>> call() => _repository.getProfile();
}
