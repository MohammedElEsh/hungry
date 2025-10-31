import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final Function signUp;

  const SignupForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.isLoading,
    required this.signUp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),

          child: Column(
            children: [
              Gap(40.h),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Full Name",
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
              CustomTextField(
                controller: nameController,
                hintText: 'Full Name',
                isPassword: false,
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              Gap(16.h),

              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email Address",
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
              CustomTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  isPassword: false,
                  validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                ),
              Gap(16.h),

              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
              CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                ),
              Gap(16.h),

              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirm Password",
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                isPassword: true,
                validator: (value) => value!.isEmpty ? 'Please confirm your password' : null,
              ),
              Gap(50.h),
              isLoading
                  ? const CupertinoActivityIndicator(
                color: AppColors.primary,
              )
                  : CustomButton(
                text: isLoading ? 'Loading...' : 'Sign Up',
                onPressed: () => signUp(),
              ),
              Gap(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go(AppRouter.kLoginView); // Navigate to login screen
                    },
                    child: Text(
                      "Login",
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
