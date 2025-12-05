import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/utils/app_colors.dart';

class GuestProfileImage extends StatelessWidget {
  final double? height;
  final double? width;

  const GuestProfileImage({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height ?? 120.h,
        width: width ?? 120.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 3.w),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          color: AppColors.primary,
        ),
        child: Center(
          child: Icon(
            CupertinoIcons.person_fill,
            color: AppColors.white,
            size: 50.sp,
          ),
        ),
      ),
    );
  }
}
