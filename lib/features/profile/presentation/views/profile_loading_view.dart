import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/skeleton_loading.dart';
import '../handlers/profile_controllers.dart';
import '../widgets/profile_actions.dart';
import '../widgets/profile_fields.dart';
import '../widgets/profile_image.dart';

/// Loading/skeleton state view. Matches [ProfileLoggedInView] layout with shimmer placeholders.
class ProfileLoadingView extends StatelessWidget {
  final ProfileControllers controllers;

  const ProfileLoadingView({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 90.h),
      child: skeletonize(
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImage(showUploadButton: false, imageUrl: ''),
            Gap(40.h),
            ProfileFields(
              nameController: controllers.name,
              emailController: controllers.email,
              addressController: controllers.address,
            ),
            Gap(20.h),
            _buildCardSkeleton(),
            Gap(60.h),
            const ProfileActions(),
            Gap(20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCardSkeleton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        height: 72.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Debit Card',
                    style: AppTextStyles.titleMedium.copyWith(color: AppColors.grey),
                  ),
                  Gap(4.h),
                  Text(
                    '**** **** **** ****',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
