import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

class GuestProfileFields extends StatelessWidget {
  const GuestProfileFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          // Guest Info Card
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.primary,
                      size: 24.sp,
                    ),
                    Gap(12.w),
                    Text(
                      'Guest Mode',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                Gap(12.h),
                Text(
                  'You are currently browsing as a guest. Create an account to unlock all features:',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.grey,
                    height: 1.5,
                  ),
                ),
                Gap(16.h),
                _buildFeatureItem('guest_profile_feature_1'.tr()),
                Gap(8.h),
                _buildFeatureItem('guest_profile_feature_2'.tr()),
                Gap(8.h),
                _buildFeatureItem('guest_profile_feature_3'.tr()),
                Gap(8.h),
                _buildFeatureItem('guest_profile_feature_4'.tr()),
                Gap(8.h),
                _buildFeatureItem('guest_profile_feature_5'.tr()),
              ],
            ),
          ),
          Gap(50.h),
          Divider(),
          Gap(20.h),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: AppColors.primary, size: 18.sp),
        Gap(8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13.sp, color: AppColors.black),
          ),
        ),
      ],
    );
  }
}
