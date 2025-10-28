import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/utils/app_colors.dart';

class ProfileImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;

  const ProfileImage({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
  });

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
          image: imageUrl != null && imageUrl!.isNotEmpty
              ? DecorationImage(
            image: NetworkImage(imageUrl!),
            fit: BoxFit.cover,
          )
              : null,
          color: AppColors.primary, // fallback background color
        ),
        child: (imageUrl == null || imageUrl!.isEmpty)
            ? Icon(
          Icons.person,
          color: AppColors.white,
          size: 60.sp,
        )
            : null,
      ),
    );
  }
}
