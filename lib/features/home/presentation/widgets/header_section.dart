import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(60.h),
            Text(
              "HUNGRY?",
              style: AppTextStyles.displayLarge.copyWith(
                color: AppColors.primary,
                fontSize: 50.sp,
              ),
            ),
            Gap(2.h),
            Text(
              "Hello, Username",
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: CircleAvatar(
            radius: 35.h,
            backgroundColor: AppColors.primary,
            child: Icon(
              CupertinoIcons.person,
              color: AppColors.white,
              size: 30.w,
            ),
          ),
        ),
      ],
    );
  }
}
