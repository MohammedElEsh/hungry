import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/skeleton_loading.dart';

/// Login skeleton while loading. Matches [LoginFormView] layout with shimmer placeholders.
class LoginLoadingView extends StatelessWidget {
  const LoginLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Stack(
            children: [
              // Top: title area (same as LoginFormView)
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: Column(
                    children: [
                      Text('login'.tr(), style: AppTextStyles.displayLarge),
                      Gap(8.h),
                      Text(
                        'login_subtitle'.tr(),
                        style: AppTextStyles.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom: skeleton card (mirrors LoginForm)
              Align(
                alignment: Alignment.bottomCenter,
                child: skeletonize(
                  enabled: true,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Gap(40.h),
                        // Email label
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            'email'.tr(),
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                        Gap(8.h),
                        // Email field placeholder
                        Container(
                          height: 52.h,
                          decoration: BoxDecoration(
                            color: AppColors.surface.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        Gap(24.h),
                        // Password label
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            'password'.tr(),
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                        Gap(8.h),
                        // Password field placeholder
                        Container(
                          height: 52.h,
                          decoration: BoxDecoration(
                            color: AppColors.surface.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        Gap(48.h),
                        // Login button placeholder
                        Container(
                          width: 0.9.sw,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        Gap(24.h),
                        // Sign up row placeholder
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "dont_have_account".tr(),
                              style: AppTextStyles.titleMedium.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                            Text(
                              'signup'.tr(),
                              style: AppTextStyles.titleMedium.copyWith(
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                        Gap(16.h),
                        // Guest button placeholder
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 24.w,
                          ),
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
                                Icons.person_outline,
                                color: AppColors.grey,
                                size: 20.sp,
                              ),
                              Gap(8.w),
                              Text(
                                'continue_as_guest'.tr(),
                                style: AppTextStyles.titleMedium.copyWith(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
