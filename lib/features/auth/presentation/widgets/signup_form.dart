import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/widgets/terms_privacy_links.dart';
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

class SignupForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final Function signUp;
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onAppleSignIn;

  const SignupForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.isLoading,
    required this.signUp,
    this.onGoogleSignIn,
    this.onAppleSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650.h,
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
              Gap(30.h),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "full_name".tr(),
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
              CustomTextField(
                controller: nameController,
                hintText: 'full_name'.tr(),
                isPassword: false,
                validator: (value) =>
                    value!.isEmpty ? 'please_enter_name'.tr() : null,
              ),
              Gap(10.h),

              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "email_address".tr(),
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
              CustomTextField(
                controller: emailController,
                hintText: 'email_address'.tr(),
                isPassword: false,
                validator: (value) =>
                    value!.isEmpty ? 'please_enter_email'.tr() : null,
              ),
              Gap(10.h),

              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "password".tr(),
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
              CustomTextField(
                controller: passwordController,
                hintText: 'password'.tr(),
                isPassword: true,
                validator: (value) =>
                    value!.isEmpty ? 'please_enter_password'.tr() : null,
              ),
              Gap(10.h),

              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "confirm_password".tr(),
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'confirm_password'.tr(),
                isPassword: true,
                validator: (value) =>
                    value!.isEmpty ? 'please_confirm_password'.tr() : null,
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
                      text: 'signup'.tr(),
                      onPressed: () => signUp(),
                    ),
              if (onGoogleSignIn != null)
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
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
                  padding: EdgeInsets.only(top: 12.h),
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
              Gap(16.h),
              TermsPrivacyLinks(textStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.grey)),
              Gap(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "already_have_account".tr(),
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  Gap(5.w),
                  GestureDetector(
                    onTap: () {
                      context.go(
                        AppRouter.kLoginView,
                      ); // Navigate to login screen
                    },
                    child: Text(
                      "login".tr(),
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
