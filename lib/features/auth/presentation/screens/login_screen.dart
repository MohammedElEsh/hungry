import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import '../cubit/auth_cubit.dart';
import '../listeners/auth_listener.dart';
import '../views/login_view_factory.dart';

/// Login screen: Scaffold + BlocConsumer, controllers, dispose.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.text = 'md36@gmail.com';
    _passwordController.text = '123456789';
    super.initState();
  }
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) => handleAuthState(context, state),
        builder: (context, state) {
          return LoginViewFactory.build(
            context,
            state,
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
            onSubmit: () => _onSubmit(context),
            onGuestMode: () => context.go(AppRouter.kHomeView),
          );
        },
      ),
    );
  }
}
