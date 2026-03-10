import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hungry/features/auth/presentation/views/login_loading_view.dart';

import '../cubit/profile_cubit.dart';
import '../handlers/profile_controllers.dart';
import 'profile_error_view.dart';
import 'profile_guest_view.dart';
import 'profile_logged_in_view.dart';
import 'profile_loading_view.dart';

/// Returns the appropriate view for each Bloc state. No logic, only mapping.
class ProfileViewFactory {
  const ProfileViewFactory._();

  static Widget build(
    BuildContext context,
    ProfileState state, {
    required ProfileControllers controllers,
    required File? pickedImage,
    required VoidCallback onUpload,
    required VoidCallback onUpdate,
    required VoidCallback onLogOut,
    required VoidCallback onGuestLogOut,
    required VoidCallback onSignUp,
    VoidCallback? onDeleteAccount,
  }) {
    if (state is ProfileGuest) {
      return ProfileGuestView(
        onSignUp: onSignUp,
        onLogOut: onGuestLogOut,
      );
    }
    if (state is ProfileLoggingOut) {
      return const LoginLoadingView();
    }
    if (state is ProfileLoading) {
      return ProfileLoadingView(controllers: controllers);
    }
    if (state is ProfileError) {
      return ProfileErrorView(message: state.message);
    }
    if (state is ProfileLoaded || state is ProfileUpdateFailed) {
      final profile = state is ProfileLoaded
          ? state.profile
          : (state as ProfileUpdateFailed).profile;
      return ProfileLoggedInView(
        profile: profile,
        controllers: controllers,
        pickedImage: pickedImage,
        onUpload: onUpload,
        onUpdate: onUpdate,
        onLogOut: onLogOut,
        onDeleteAccount: onDeleteAccount,
      );
    }
    return ProfileLoadingView(controllers: controllers);
  }
}
