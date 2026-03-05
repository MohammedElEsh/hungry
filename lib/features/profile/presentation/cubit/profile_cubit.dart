import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/profile_logout_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfile;
  final UpdateProfileUseCase _updateProfile;
  final ProfileLogoutUseCase _logout;

  ProfileCubit(this._getProfile, this._updateProfile, this._logout)
      : super(ProfileInitial());

  Future<void> loadProfile() async {
    if (isClosed) return;
    emit(ProfileLoading());
    final result = await _getProfile();
    if (isClosed) return;
    result.when(
      success: (profile) {
        if (profile == null) {
          emit(ProfileGuest());
        } else {
          emit(ProfileLoaded(profile));
        }
      },
      onFailure: (f) => emit(ProfileError(f.message)),
    );
  }

  Future<void> update(ProfileEntity profile, {File? imageFile}) async {
    final current = state;
    if (current is! ProfileLoaded || isClosed) return;
    emit(ProfileLoading());
    final result = await _updateProfile(profile, imageFile: imageFile);
    if (isClosed) return;
    result.when(
      success: (updated) => emit(ProfileLoaded(updated)),
      onFailure: (f) => emit(ProfileUpdateFailed(current.profile, f.message)),
    );
  }

  Future<bool> logout() async {
    if (isClosed) return false;
    emit(ProfileLoggingOut());
    final result = await _logout();
    if (isClosed) return false;
    return result.when(
      success: (_) => true,
      onFailure: (f) {
        emit(ProfileError(f.message));
        return false;
      },
    );
  }
}
