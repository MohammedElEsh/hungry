import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/domain/result.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../features/auth/domain/entities/user_entity.dart';
import '../../../../features/auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemote;
  final AuthRepository _authRepository;

  ProfileRepositoryImpl(this._profileRemote, this._authRepository);

  @override
  Future<Result<ProfileEntity?>> getProfile() async {
    if (_authRepository.isGuest) return Success(null);
    try {
      final model = await _profileRemote.getProfile();
      if (model == null) {
        final fallback = _authRepository.currentUser;
        return Success(fallback != null ? _userToProfileEntity(fallback) : null);
      }
      return Success(model.toEntity());
    } on ServerException catch (e) {
      final fallback = _authRepository.currentUser;
      if (fallback != null) return Success(_userToProfileEntity(fallback));
      return FailureResult(ServerFailure(e.message));
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } catch (e) {
      final fallback = _authRepository.currentUser;
      if (fallback != null) return Success(_userToProfileEntity(fallback));
      return FailureResult(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<ProfileEntity>> updateProfile(
    ProfileEntity profile, {
    Object? imageFile,
  }) async {
    try {
      final File? file = imageFile is File ? imageFile : null;
      final formData = FormData.fromMap({
        'name': profile.name,
        'email': profile.email,
        if (profile.address != null && profile.address!.isNotEmpty)
          'address': profile.address,
        if (profile.visa != null && profile.visa!.isNotEmpty) 'visa': profile.visa,
        if (file != null)
          'image': MultipartFile.fromFile(
            file.path,
            filename: file.path.split(RegExp(r'[/\\]')).last,
          ),
      });

      final model = await _profileRemote.updateProfile(formData);
      final userEntity = UserEntity(
        id: model.id,
        email: model.email,
        name: model.name,
        token: _authRepository.currentUser?.token,
        address: model.address,
        visa: model.visa,
        image: model.image,
      );
      _authRepository.updateSessionUser(userEntity);
      return Success(model.toEntity());
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> changePassword(
      String currentPassword, String newPassword) async {
    try {
      await _profileRemote.changePassword(currentPassword, newPassword);
      return const Success(null);
    } on ServerException catch (e) {
      if (e.message.contains('change_password_not_available') ||
          e.message.contains('not_available') ||
          e.message.contains('404') ||
          e.message.contains('501')) {
        return FailureResult(
            UnimplementedFailure('change_password_not_available'));
      }
      return FailureResult(ServerFailure(e.message));
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteAccount(String? password) async {
    try {
      await _profileRemote.deleteAccount();
      final result = await _authRepository.logout();
      return result.when(
        success: (_) => const Success(null),
        onFailure: (f) => FailureResult(f),
      );
    } on ServerException catch (e) {
      if (e.message.contains('delete_account_not_available') ||
          e.message.contains('not_available') ||
          e.message.contains('404') ||
          e.message.contains('501')) {
        return FailureResult(
            UnimplementedFailure('delete_account_not_available'));
      }
      return FailureResult(ServerFailure(e.message));
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> logout() async {
    final result = await _authRepository.logout();
    return result.when(
      success: (_) => const Success(null),
      onFailure: (f) => FailureResult(ServerFailure('Failed to log out')),
    );
  }

  ProfileEntity _userToProfileEntity(UserEntity u) => ProfileEntity(
        id: u.id.isNotEmpty ? u.id : u.email,
        name: (u.name ?? '').trim().isNotEmpty ? (u.name ?? '').trim() : u.email,
        email: u.email,
        address: u.address?.trim().isEmpty == true ? null : u.address,
        visa: u.visa?.trim().isEmpty == true ? null : u.visa,
        image: u.image?.trim().isEmpty == true ? null : u.image,
      );
}
