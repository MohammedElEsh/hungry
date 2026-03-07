import 'package:hungry/core/domain/result.dart';

import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Result<ProfileEntity?>> getProfile();
  Future<Result<ProfileEntity>> updateProfile(
    ProfileEntity profile, {
    Object? imageFile,
  });
  Future<Result<void>> logout();
}
