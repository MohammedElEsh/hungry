import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
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

  const SignupFormView({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.isLoading,
    required this.onSignUp,
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
                    Text("sign up", style: AppTextStyles.displayLarge),
                    Text(
                      "please sign up to get started",
                      style: AppTextStyles.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: SignupForm(
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  formKey: formKey,
                  isLoading: isLoading,
                  signUp: onSignUp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
