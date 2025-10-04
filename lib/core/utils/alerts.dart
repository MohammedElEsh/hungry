import 'package:alert_banner/exports.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'styles.dart';
import 'size_config.dart';

/// 🔔 Base method to build a custom banner (responsive with SizeConfig)
void _showBanner(
    BuildContext context,
    String message,
    Color backgroundColor,
    ) {
  final sizeConfig = SizeConfig(context);

  final child = Container(
    width: double.infinity,
    constraints: BoxConstraints(
      maxWidth: sizeConfig.width * 0.9,
    ),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(sizeConfig.width * 0.02),
    ),
    padding: EdgeInsets.symmetric(
      vertical: sizeConfig.height * 0.015,
      horizontal: sizeConfig.width * 0.04,
    ),
    child: Material(
      color: Colors.transparent,
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.labelLarge.copyWith(
          color: AppColors.white,
          fontSize: sizeConfig.width * 0.04, // responsive font size
        ),
      ),
    ),
  );

  showAlertBanner(
    context,
        () {}, // optional onTap callback
    child,
    alertBannerLocation: AlertBannerLocation.top,
  );
}

/// ❌ Error banner (red)
void showErrorBanner(BuildContext context, String message) {
  _showBanner(context, message, AppColors.error);
}

/// ✅ Success banner (green)
void showSuccessBanner(BuildContext context, String message) {
  _showBanner(context, message, AppColors.success);
}

/// ⚠️ Warning banner (yellow)
void showWarningBanner(BuildContext context, String message) {
  _showBanner(context, message, AppColors.warning);
}

/// ℹ️ Info banner (blue)
void showInfoBanner(BuildContext context, String message) {
  _showBanner(context, message, AppColors.info);
}
