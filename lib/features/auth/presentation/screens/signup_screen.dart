import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/alerts.dart';
import '../cubit/auth_cubit.dart';
import '../listeners/auth_listener.dart';
import '../handlers/auth_handlers.dart';
import '../views/signup_form_view.dart';

/// Signup screen: BlocConsumer, controllers, dispose. Uses AuthCubit.
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUp(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      AuthHandlers.signUp(
        context,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        handleAuthState(context, state);
        if (state is AuthLoaded && context.mounted) {
          showSuccessBanner(context, 'Account created successfully!');
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return SignupFormView(
          nameController: _nameController,
          emailController: _emailController,
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
          formKey: _formKey,
          isLoading: isLoading,
          onSignUp: () => _onSignUp(context),
          onGoogleSignIn: () => context.read<AuthCubit>().loginWithGoogle(),
          onAppleSignIn: () => context.read<AuthCubit>().loginWithApple(),
        );
      },
    );
  }
}
