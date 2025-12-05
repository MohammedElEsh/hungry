import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class CustomizedText extends StatelessWidget {
  const CustomizedText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Customize",
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: " Your Burger\n to Your Tastes.\n Ultimate Experience",
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.black),
          ),
        ],
      ),
      textAlign: TextAlign.start,
    );
  }
}
