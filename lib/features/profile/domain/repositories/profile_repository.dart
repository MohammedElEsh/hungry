import '../entities/profile_entity.dart';
import '../result.dart';

abstract class ProfileRepository {
  Future<Result<ProfileEntity?>> getProfile();
  Future<Result<ProfileEntity>> updateProfile(
    ProfileEntity profile, {
    Object? imageFile,
  });
  Future<Result<void>> logout();
}
