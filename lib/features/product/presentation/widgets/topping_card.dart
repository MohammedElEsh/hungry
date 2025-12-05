import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class ToppingCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final Color buttonColor;

  const ToppingCard({
    super.key,
    required this.text,
    required this.imagePath,
    this.buttonColor = AppColors.error,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      height: 150.h,
      decoration: BoxDecoration(
        color: AppColors.third,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        children: [
          Container(
            height: 70.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              height: 65.h,
              width: 130.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 6.w, right: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text, style: AppTextStyles.titleMedium),
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: AppColors.white, size: 18.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
