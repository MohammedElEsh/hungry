import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
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
    final sizeConfig = SizeConfig(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
              (index) => GestureDetector(
            onTap: () => onCategoryTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: EdgeInsets.only(right: sizeConfig.width * 0.03),
              padding: EdgeInsets.symmetric(
                horizontal: sizeConfig.width * 0.09,
                vertical: sizeConfig.height * 0.02,
              ),
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? AppColors.primary
                    // ignore: deprecated_member_use
                    : AppColors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
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
