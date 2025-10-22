import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/utils/assets.dart';
import '../../../../core/utils/app_colors.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120.h,
        width: 120.w,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AssetsData.user)),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.white, width: 3.w),
          color: AppColors.grey,
        ),
      ),
    );
  }
}
