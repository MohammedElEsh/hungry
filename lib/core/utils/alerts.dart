import 'package:alert_banner/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'styles.dart';

void _showBanner(
    BuildContext context,
    String message,
    Color backgroundColor,
    ) {
  final child = Container(
    width: double.infinity,
    constraints: BoxConstraints(
      maxWidth: 0.9.sw,
    ),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8.r),
    ),
    padding: EdgeInsets.symmetric(
      vertical: 12.h,
      horizontal: 16.w,
    ),
    child: Material(
      color: Colors.transparent,
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.labelLarge.copyWith(
          color: AppColors.white,
        ),
      ),
    ),
  );

  showAlertBanner(
    context,
        () {},
    child,
    alertBannerLocation: AlertBannerLocation.top,
  );
}

void showErrorBanner(BuildContext context, String message) {
  _showBanner(context, message, AppColors.error);
}

void showSuccessBanner(BuildContext context, String message) {
  _showBanner(context, message, AppColors.success);
}

void showWarningBanner(BuildContext context, String message) {
  _showBanner(context, message, AppColors.warning);
}

void showInfoBanner(BuildContext context, String message) {
  _showBanner(context, message, AppColors.info);
}
