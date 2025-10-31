import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized text styles for the app
/// Naming convention is aligned with Material 3 (Flutter standard)
/// https://m3.material.io/styles/typography/overview
abstract class AppTextStyles {
  // ================== Display ==================
  static final displayLarge = GoogleFonts.luckiestGuy(
    textStyle: const TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w500,
      color: AppColors.forth,
    ),
  );

  static final displayMedium = GoogleFonts.luckiestGuy(
    textStyle: const TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
  );

  static final displaySmall = GoogleFonts.luckiestGuy(
    textStyle: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
  );

  // ================== Headline ==================
  static final headlineLarge = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
  );

  static final headlineMedium = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
  );

  static final headlineSmall = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
  );

  // ================== Title ==================
  static final titleLarge = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
  );

  static final titleMedium = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
  );

  static final titleSmall = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
  );

  // ================== Body ==================
  static final bodyLarge = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
  );

  static final bodyMedium = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
  );

  static final bodySmall = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
  );

  // ================== Label ==================
  static final labelLarge = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
  );

  static final labelMedium = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
  );

  static final labelSmall = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
  );

  // ================== Optional dark text (for light backgrounds) ==================
  static final bodyBlack = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
  );
  static final bodyBrown = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.third,
    ),
  );

    static final bodyGrey = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.grey,
    ),
  );


}
