import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
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
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onAppleSignIn;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.isLoading,
    required this.login,
    this.onGuestMode,
    this.onGoogleSignIn,
    this.onAppleSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 580.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Gap(30.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "email".tr(),
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
                hintText: 'email_address'.tr(),
                isPassword: false,
                validator: (value) =>
                    value!.isEmpty ? 'email_is_required'.tr() : null,
              ),
            ),
            Gap(10.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "password".tr(),
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
                hintText: 'password'.tr(),
                isPassword: true,
                validator: (value) =>
                    value!.isEmpty ? 'password_is_required'.tr() : null,
              ),
            ),

            Gap(30.h),
            isLoading
                ? SizedBox(
                    height: 56.h,
                    child: const Center(
                      child: CupertinoActivityIndicator(
                        color: AppColors.primary,
                        radius: 12,
                      ),
                    ),
                  )
                : CustomButton(
                    width: 0.9.sw,
                    text: 'login'.tr(),
                    onPressed: () => login(),
                  ),
            Gap(10.h),
            Align(
              alignment: AlignmentDirectional.center,
              child: GestureDetector(
                onTap: () => context.go(AppRouter.kForgetPasswordView),
                child: Text(
                  'forget_password'.tr(),
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.secondary,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Gap(20.h),
            // Social sign-in buttons
            if (onGoogleSignIn != null)
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: SizedBox(
                  width: 0.9.sw,
                  child: OutlinedButton.icon(
                    onPressed: isLoading ? null : onGoogleSignIn,
                    icon: FaIcon(FontAwesomeIcons.google, size: 18.sp, color: AppColors.grey),
                    label: Text('sign_in_with_google'.tr()),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.grey,
                      side: BorderSide(color: AppColors.grey.withOpacity(0.5)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                  ),
                ),
              ),
            if (onAppleSignIn != null)
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: SizedBox(
                  width: 0.9.sw,
                  child: OutlinedButton.icon(
                    onPressed: isLoading ? null : onAppleSignIn,
                    icon: FaIcon(FontAwesomeIcons.apple, size: 18.sp, color: AppColors.grey),
                    label: Text('sign_in_with_apple'.tr()),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.grey,
                      side: BorderSide(color: AppColors.grey.withOpacity(0.5)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                  ),
                ),
              ),
            if (onGoogleSignIn != null || onAppleSignIn != null) Gap(8.h),
            // Add "Don't have an account?" message and sign up link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "dont_have_account".tr(),
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                Gap(5.w),
                GestureDetector(
                  onTap: () {
                    context.go(AppRouter.kSignupView); // Go to signup screen
                  },
                  child: Text(
                    "signup".tr(),
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
                      "continue_as_guest".tr(),
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
