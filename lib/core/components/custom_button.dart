import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? borderRadius;

  const CustomButton({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? 170.w,
        height: height ?? 60.h,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
        ),
        alignment: Alignment.center,
        child: icon != null
            ? Icon(icon, color: textColor ?? AppColors.white, size: 24.sp)
            : Text(
          text ?? '',
          style: AppTextStyles.titleMedium.copyWith(
            color: textColor ?? AppColors.white,
          ),
        ),
      ),
    );
  }
}
