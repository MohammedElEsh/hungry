import 'dart:io';

import '../../../../features/auth/data/models/user_model.dart';
import '../../../../features/auth/data/repositories/auth_repo.dart';
import '../../../../core/domain/result.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final AuthRepo _authRepo;

  ProfileRepositoryImpl(this._authRepo);

  @override
  Future<Result<ProfileEntity?>> getProfile() async {
    try {
      if (_authRepo.isGuest) return Success(null);
      UserModel? user;
      try {
        user = await _authRepo.getProfileData();
      } catch (_) {
        user = _authRepo.currentUserModel;
      }
      if (user == null) return Success(null);
      return Success(_toEntity(user));
    } catch (e) {
      final fallback = _authRepo.currentUserModel;
      if (fallback != null) return Success(_toEntity(fallback));
      return FailureResult(ServerFailure('Failed to load profile'));
    }
  }

  @override
  Future<Result<ProfileEntity>> updateProfile(
    ProfileEntity profile, {
    Object? imageFile,
  }) async {
    try {
      final File? file = imageFile is File ? imageFile : null;
      final user = await _authRepo.updateProfileData(
        name: profile.name,
        email: profile.email,
        address: profile.address,
        visa: profile.visa,
        image: file,
      );
      return Success(_toEntity(user));
    } catch (e) {
      return FailureResult(ServerFailure('Failed to update profile'));
    }
  }

  @override
  Future<Result<void>> changePassword(String currentPassword, String newPassword) async {
    try {
      await _authRepo.changePassword(currentPassword, newPassword);
      return const Success(null);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('change_password_not_available') ||
          msg.contains('not_available') ||
          msg.contains('404') ||
          msg.contains('501')) {
        return FailureResult(UnimplementedFailure('change_password_not_available'));
      }
      return FailureResult(ServerFailure(msg));
    }
  }

  @override
  Future<Result<void>> deleteAccount(String? password) async {
    try {
      await _authRepo.deleteAccount(password);
      await _authRepo.logout();
      return const Success(null);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('delete_account_not_available') ||
          msg.contains('not_available') ||
          msg.contains('404') ||
          msg.contains('501')) {
        return FailureResult(UnimplementedFailure('delete_account_not_available'));
      }
      return FailureResult(ServerFailure(msg));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _authRepo.logout();
      return const Success(null);
    } catch (e) {
      return FailureResult(ServerFailure('Failed to log out'));
    }
  }

  ProfileEntity _toEntity(UserModel u) => ProfileEntity(
        id: u.id.isNotEmpty ? u.id : u.email,
        name: (u.name ?? '').trim().isNotEmpty ? (u.name ?? '').trim() : u.email,
        email: u.email,
        address: u.address?.trim().isEmpty == true ? null : u.address,
        visa: u.visa?.trim().isEmpty == true ? null : u.visa,
        image: u.image?.trim().isEmpty == true ? null : u.image,
      );
}
