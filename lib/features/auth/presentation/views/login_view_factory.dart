import 'package:flutter/material.dart';

import '../cubit/auth_cubit.dart';
import 'login_form_view.dart';

/// Returns login view for each Auth state. Loading shows form + small indicator (no skeleton).
class LoginViewFactory {
  const LoginViewFactory._();

  static Widget build(
    BuildContext context,
    AuthState state, {
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required VoidCallback onSubmit,
    VoidCallback? onGuestMode,
  }) {
    return LoginFormView(
      formKey: formKey,
      emailController: emailController,
      passwordController: passwordController,
      onSubmit: onSubmit,
      isLoading: state is AuthLoading,
      onGuestMode: onGuestMode,
    );
  }
}
