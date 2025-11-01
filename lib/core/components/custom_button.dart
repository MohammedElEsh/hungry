import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

/// A highly customizable button widget that supports:
/// - Text and/or Icon
/// - Gradient background
/// - Border and shadow
/// - Ripple effect
/// - Loading state
/// - Flexible width, height, and styling
class CustomButton extends StatelessWidget {
  /// Text to display on the button
  final String? text;

  /// Icon to display on the button (optional)
  final IconData? icon;

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  /// Background color (ignored if gradient is provided)
  final Color? backgroundColor;

  /// Optional gradient for the button background
  final Gradient? gradient;

  /// Text color
  final Color? textColor;

  /// Button height
  final double? height;

  /// Button width
  final double? width;

  /// Border radius
  final double? borderRadius;

  /// Optional border for the button
  final Border? border;

  /// If true, shows a loading spinner instead of text/icon
  final bool isLoading;

  /// Icon size
  final double? iconSize;

  /// Optional custom text style
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.transparent,
    this.gradient,
    this.textColor,
    this.height,
    this.width,
    this.borderRadius,
    this.border,
    this.isLoading = false,
    this.iconSize,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // Transparent material for ripple effect
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
        child: Container(
          width: width ?? 170.w,
          height: height ?? 60.h,
          decoration: BoxDecoration(
            // If gradient is null, use solid color
            color: gradient == null ? (backgroundColor ?? AppColors.primary) : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
            border: border,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: isLoading
          // Show CircularProgressIndicator when loading
              ? SizedBox(
            width: 24.w,
            height: 24.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: textColor ?? AppColors.white,
            ),
          )
          // Show Row with Icon + Text
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(icon, color: textColor ?? AppColors.white, size: iconSize ?? 24.sp),
              if (icon != null && text != null) SizedBox(width: 8.w),
              if (text != null)
                Text(
                  text!,
                  style: textStyle ??
                      AppTextStyles.titleMedium.copyWith(
                        color: textColor ?? AppColors.white,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
