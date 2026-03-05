import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/alerts.dart';
import '../cubit/auth_cubit.dart';

/// Auth actions: submit login, submit signup (with validation). No UI.
class AuthHandlers {
  const AuthHandlers._();

  static void login(
    BuildContext context, {
    required String email,
    required String password,
  }) {
    context.read<AuthCubit>().login(email, password);
  }

  /// Returns true if validation passed and register was called.
  static bool signUp(
    BuildContext context, {
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    if (password != confirmPassword) {
      showErrorBanner(context, 'Passwords do not match');
      return false;
    }
    context.read<AuthCubit>().register(email, password, name);
    return true;
  }
}
