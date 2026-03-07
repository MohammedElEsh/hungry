import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

/// Centralized text styles. Font sizes use [ScreenUtil].sp for responsive scaling.
/// Naming aligned with Material 3: https://m3.material.io/styles/typography/overview
abstract class AppTextStyles {
  // ================== Display ==================
  static TextStyle get displayLarge => GoogleFonts.luckiestGuy(
        textStyle: TextStyle(
          fontSize: 60.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.forth,
        ),
      );

  static TextStyle get displayMedium => GoogleFonts.luckiestGuy(
        textStyle: TextStyle(
          fontSize: 45.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
      );

  static TextStyle get displaySmall => GoogleFonts.luckiestGuy(
        textStyle: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
      );

  // ================== Headline ==================
  static TextStyle get headlineLarge => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
      );

  static TextStyle get headlineMedium => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      );

  static TextStyle get headlineSmall => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      );

  // ================== Title ==================
  static TextStyle get titleLarge => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      );

  static TextStyle get titleMedium => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      );

  static TextStyle get titleSmall => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      );

  // ================== Body ==================
  static TextStyle get bodyLarge => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
      );

  static TextStyle get bodyMedium => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
      );

  static TextStyle get bodySmall => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
      );

  // ================== Label ==================
  static TextStyle get labelLarge => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      );

  static TextStyle get labelMedium => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      );

  static TextStyle get labelSmall => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      );

  // ================== Optional dark text (for light backgrounds) ==================
  static TextStyle get bodyBlack => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      );

  static TextStyle get bodyBrown => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.third,
        ),
      );

  static TextStyle get bodyGrey => GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.grey,
        ),
      );
}
