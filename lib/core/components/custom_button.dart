import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? sizeConfig.width * 0.45,
        height: height ?? sizeConfig.height * 0.08,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(
            sizeConfig.width * 0.06,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTextStyles.titleMedium
        ),
      ),
    );
  }
}
