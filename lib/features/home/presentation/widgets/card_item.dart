import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/styles.dart';

class CardItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final double rating;

  const CardItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig(context);

    return Card(
      color: AppColors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sizeConfig.width * 0.05,
          vertical: sizeConfig.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              width: sizeConfig.width * 0.35,
              height: sizeConfig.height * 0.15,
            ),
            Gap(sizeConfig.height * 0.001),
            Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
            Text(
              price,
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.grey,
              ),
            ),
            Gap(sizeConfig.height * 0.005),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: sizeConfig.width * 0.04,
                ),
                SizedBox(width: sizeConfig.width * 0.01),
                Text(
                  rating.toString(),
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
