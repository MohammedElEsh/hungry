import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/constants/app_colors.dart';

import '../../../../core/utils/styles.dart';
import '../widgets/signup_form.dart';

/// Signup form view. Controllers and callbacks from screen.
class SignupFormView extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final VoidCallback onSignUp;
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onAppleSignIn;

  const SignupFormView({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.isLoading,
    required this.onSignUp,
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
                padding: EdgeInsets.only(top: 40.h),
                child: Column(
                  children: [
                    Text("signup".tr(), style: AppTextStyles.displayLarge),
                    Text(
                      "signup_subtitle".tr(),
                      style: AppTextStyles.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child:                 SignupForm(
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  formKey: formKey,
                  isLoading: isLoading,
                  signUp: onSignUp,
                  onGoogleSignIn: onGoogleSignIn,
                  onAppleSignIn: onAppleSignIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
