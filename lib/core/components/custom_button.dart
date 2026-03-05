import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/styles.dart';
import '../constants/app_colors.dart';

/// Button variants: filled, outlined, or text only
enum ButtonVariant { filled, outlined, text }

/// Icon position in the button: start (left) or end (right)
enum IconPosition { start, end }

/// Highly customizable button widget with:
/// - Text and/or Icon
/// - Gradient background
/// - Border and shadow
/// - Ripple effect
/// - Loading state
/// - Disabled state
/// - Flexible width, height, padding, and styling
class CustomButton extends StatelessWidget {
  /// Text to display on the button
  final String? text;

  /// Optional text to display while loading
  final String? loadingText;

  /// Optional icon to display on the button
  final IconData? icon;

  /// Callback function when the button is pressed
  final VoidCallback? onPressed;

  /// Background color (ignored if gradient is provided)
  final Color? backgroundColor;

  /// Gradient background for the button
  final Gradient? gradient;

  /// Text color
  final Color? textColor;

  /// Button height
  final double? height;

  /// Button width
  final double? width;

  /// Border radius for rounded corners
  final double? borderRadius;

  /// Optional border for the button
  final Border? border;

  /// Show loading spinner instead of text/icon
  final bool isLoading;

  /// Disable button interaction
  final bool isDisabled;

  /// Icon size
  final double? iconSize;

  /// Custom text style
  final TextStyle? textStyle;

  /// Padding inside the button
  final EdgeInsetsGeometry? padding;

  /// Button variant: filled, outlined, or text
  final ButtonVariant variant;

  /// Position of the icon: start or end
  final IconPosition iconPosition;

  /// Button elevation (shadow height)
  final double elevation;

  const CustomButton({
    super.key,
    this.text,
    this.loadingText,
    this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.gradient,
    this.textColor,
    this.height,
    this.width,
    this.borderRadius,
    this.border,
    this.isLoading = false,
    this.isDisabled = false,
    this.iconSize,
    this.textStyle,
    this.padding,
    this.variant = ButtonVariant.filled,
    this.iconPosition = IconPosition.start,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the button should be disabled
    final bool disabled = isDisabled || isLoading || onPressed == null;

    // Determine effective text color based on variant
    final Color effectiveTextColor =
        textColor ?? (variant == ButtonVariant.filled ? AppColors.white : AppColors.primary);

    // Determine gradient for filled variant only
    final Gradient? effectiveGradient = (variant == ButtonVariant.filled) ? gradient : null;

    // Determine background color for filled variant
    final Color effectiveBackgroundColor =
        variant == ButtonVariant.filled ? (backgroundColor ?? AppColors.primary) : Colors.transparent;

    return Semantics(
      // Accessibility: mark this widget as a button
      button: true,
      label: text,
      child: Material(
        // Transparent material to allow ripple effect
        color: Colors.transparent,
        elevation: elevation, // Shadow elevation
        child: Ink(
          width: width ?? 170.w, // Default width
          height: height ?? 60.h, // Default height
          decoration: BoxDecoration(
            // Disabled button color
            color: disabled ? AppColors.grey.withOpacity(0.3) : effectiveBackgroundColor,
            gradient: disabled ? null : effectiveGradient,
            borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
            border: border ??
                (variant == ButtonVariant.outlined
                    ? Border.all(color: AppColors.primary, width: 1.5)
                    : null),
            boxShadow: [
              if (!disabled && elevation > 0)
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: InkWell(
            onTap: disabled ? null : onPressed, // Disable interaction if needed
            borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
            splashFactory: InkRipple.splashFactory, // Ripple effect
            highlightColor: Colors.transparent, // Remove default highlight color
            child: Padding(
              padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
              child: Center(
                // Animate between loading spinner and content
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isLoading
                      ? SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: effectiveTextColor,
                          ),
                        )
                      : _buildContent(effectiveTextColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the content of the button (icon + text)
  Widget _buildContent(Color effectiveTextColor) {
    final List<Widget> children = [];

    // If icon is at the start
    if (icon != null && iconPosition == IconPosition.start) {
      children.add(Icon(
        icon,
        color: effectiveTextColor,
        size: iconSize ?? 24.sp,
      ));
      if (text != null) children.add(SizedBox(width: 8.w)); // Space between icon and text
    }

    // Add the text
    if (text != null) {
      children.add(Text(
        isLoading && loadingText != null ? loadingText! : text!,
        style: textStyle ??
            AppTextStyles.titleMedium.copyWith(color: effectiveTextColor),
      ));
    }

    // If icon is at the end
    if (icon != null && iconPosition == IconPosition.end) {
      if (text != null) children.add(SizedBox(width: 8.w));
      children.add(Icon(
        icon,
        color: effectiveTextColor,
        size: iconSize ?? 24.sp,
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}