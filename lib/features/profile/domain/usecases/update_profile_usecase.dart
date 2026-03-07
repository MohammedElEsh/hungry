import 'dart:io';

import 'package:hungry/core/domain/result.dart';

import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<Result<ProfileEntity>> call(
    ProfileEntity profile, {
    File? imageFile,
  }) =>
      _repository.updateProfile(profile, imageFile: imageFile);
}
