import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final Function login;
  final VoidCallback? onGuestMode;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.isLoading,
    required this.login,
    this.onGuestMode,
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
        child: Column(
          children: [
            Gap(40.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextField(
                controller: emailController,
                hintText: 'Email Address',
                isPassword: false,
                validator: (value) =>
                    value!.isEmpty ? 'Email is required' : null,
              ),
            ),
            Gap(16.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                isPassword: true,
                validator: (value) =>
                    value!.isEmpty ? 'Password is required' : null,
              ),
            ),
            Gap(60.h),
            isLoading
                ? const CupertinoActivityIndicator(color: AppColors.primary)
                : CustomButton(
                    width: 0.9.sw,
                    text: isLoading ? 'Loading...' : 'Login',
                    onPressed: () => login(),
                  ),
            Gap(20.h),
            // Add "Don't have an account?" message and sign up link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.go(AppRouter.kSignupView); // Go to signup screen
                  },
                  child: Text(
                    "Sign Up",
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
            Gap(15.h),
            // Guest Mode Button
            GestureDetector(
              onTap: onGuestMode,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey.withOpacity(0.3),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.person_2,
                      color: AppColors.grey,
                      size: 20.sp,
                    ),
                    Gap(8.w),
                    Text(
                      "Continue as Guest",
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w600,
                      ),
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
