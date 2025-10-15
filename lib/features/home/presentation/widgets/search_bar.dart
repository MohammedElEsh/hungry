import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(12.r),
      child: TextField(
        style: AppTextStyles.titleMedium.copyWith(
          color: AppColors.grey,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          hintText: 'Search for restaurants...',
          hintStyle: AppTextStyles.titleMedium.copyWith(
            color: AppColors.grey,
            fontSize: 14.sp,
          ),
          fillColor: AppColors.white,
          filled: true,
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: AppColors.grey,
            size: 22.sp,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 10.w,
          ),
        ),
      ),
    );
  }
}
