import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/utils/app_colors.dart';

class ProfileImage extends StatelessWidget {
  final String? imageUrl;
  const ProfileImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120.h,
        width: 120.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 3.w),
          image: imageUrl != null && imageUrl!.isNotEmpty
              ? DecorationImage(
            image: NetworkImage(imageUrl!),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: (imageUrl == null || imageUrl!.isEmpty)
            ? Icon(Icons.person, size: 60.sp, color: AppColors.white)
            : null,
      ),
    );
  }
}
