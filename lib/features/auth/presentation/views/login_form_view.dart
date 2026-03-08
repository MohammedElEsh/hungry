import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/login_form.dart';

/// Login form view. Controllers and callbacks from screen.
class LoginFormView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final bool isLoading;
  final VoidCallback? onGuestMode;
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onAppleSignIn;

  const LoginFormView({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    required this.isLoading,
    this.onGuestMode,
    this.onGoogleSignIn,
    this.onAppleSignIn,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.primary,
        body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: Column(
                children: [
                  Text('login'.tr(), style: AppTextStyles.displayLarge),
                  Text(
                    'login_subtitle'.tr(),
                    style: AppTextStyles.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  LoginForm(
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: formKey,
                    isLoading: isLoading,
                    login: onSubmit,
                    onGuestMode: onGuestMode,
                    onGoogleSignIn: onGoogleSignIn,
                    onAppleSignIn: onAppleSignIn,
                  ),
                ],
              ),
            ),
          ),
        ],
                ),
      ),
    );
  }
}