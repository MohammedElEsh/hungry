import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class ToppingCard extends StatelessWidget {
  final String text;
  final String imageUrl;
  final Color buttonColor;
  final bool isSelected;
  final VoidCallback onTap;

  const ToppingCard({
    super.key,
    required this.text,
    required this.imageUrl,
    this.buttonColor = AppColors.error,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: 130.w,
        height: 120.h,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? buttonColor.withOpacity(0.3) : AppColors.third,
          borderRadius: BorderRadius.circular(25.r),
          border: isSelected
              ? Border.all(color: buttonColor, width: 2)
              : null,
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
              child: Image.network(
                imageUrl,
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
                  Flexible(
                    child: Text(
                      text,
                      style: AppTextStyles.titleMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle, color: buttonColor, size: 20.sp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
