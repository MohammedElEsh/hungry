import 'package:flutter/material.dart';

import '../../../../core/utils/alerts.dart';
import '../cubit/profile_cubit.dart';
import '../handlers/profile_controllers.dart';

/// Handles Bloc state side-effects only: sync form controllers, error banners.
/// No navigation or business logic.
void handleProfileState(
  BuildContext context,
  ProfileState state,
  ProfileControllers controllers,
) {
  if (state is ProfileLoaded || state is ProfileUpdateFailed) {
    final profile = state is ProfileLoaded
        ? state.profile
        : (state as ProfileUpdateFailed).profile;
    controllers.syncFromProfile(profile);
  }
  if (state is ProfileError && context.mounted) {
    showErrorBanner(context, state.message);
  }
  if (state is ProfileUpdateFailed && context.mounted) {
    showErrorBanner(context, state.message);
  }
}
