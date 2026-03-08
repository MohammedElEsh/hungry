import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_router.dart';
import '../cubit/auth_cubit.dart';

/// Auth state side-effects: navigation on success, error banner on error.
void handleAuthState(BuildContext context, AuthState state) {
  if (state is AuthLoaded) {
    // Defer navigation to next frame for a smooth transition to home
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      context.go(AppRouter.kHomeView);
    });
  }
  if (state is AuthError && context.mounted) {
    final msg = state.message.contains('will be available') ||
            state.message.contains('not available')
        ? 'social_login_not_available'.tr()
        : state.message;
    showErrorBanner(context, msg);
  }
}
