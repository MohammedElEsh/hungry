import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/styles.dart';

class ToppingCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final Color buttonColor;

  const ToppingCard({super.key,
    required this.text,
    required this.imagePath,
    this.buttonColor = AppColors.error,
  });

  @override
  Widget build(BuildContext context) {
    final size = SizeConfig(context);

    return Container(
      width: size.width * 0.35,
      height: size.height * 0.18,
      decoration: BoxDecoration(
        color: AppColors.third,
        borderRadius: BorderRadius.circular(25),
      ),

      child: Column(
        children: [
          Container(
            height: size.height * 0.09,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: AppColors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              height: size.height * 0.08,
              width: size.width * 0.35,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.01,
              left: size.width * 0.02,
              right: size.width * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text, style: AppTextStyles.titleMedium),
                Container(
                  width: size.width * 0.08,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
