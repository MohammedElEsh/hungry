import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class CategoriesList extends StatelessWidget {
  final List<String> categories;
  final int currentIndex;
  final Function(int) onCategoryTap;

  const CategoriesList({
    super.key,
    required this.categories,
    required this.currentIndex,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => GestureDetector(
            onTap: () => onCategoryTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? AppColors.secondary
                    : AppColors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                categories[index],
                style: AppTextStyles.titleMedium.copyWith(
                  color: currentIndex == index
                      ? AppColors.white
                      : AppColors.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
