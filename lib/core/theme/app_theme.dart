import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'text_styles.dart';

/// Application theme configuration.
/// Light and dark themes use full ColorScheme + theme-driven textTheme for reuse.
abstract class AppTheme {
  AppTheme._();

  // Dark surface variants (slightly lighter than primary for elevated surfaces)
  static const Color _darkSurfaceContainer = Color(0xff1a1a2e);
  static const Color _darkSurfaceContainerHigh = Color(0xff252538);
  static const Color _darkOutline = Color(0xff3d3d52);
  static const Color _darkOutlineVariant = Color(0xff2d2d42);
  static const Color _darkOnSurfaceVariant = Color(0xffb0b0c0);

  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.surface,
      onPrimaryContainer: AppColors.primary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.white,
      secondaryContainer: Color(0xffffe0d0),
      onSecondaryContainer: AppColors.tertiary,
      surface: AppColors.white,
      onSurface: AppColors.primary,
      surfaceContainerHighest: AppColors.surface,
      surfaceContainer: AppColors.background,
      onSurfaceVariant: AppColors.surfaceVariant,
      outline: AppColors.grey,
      outlineVariant: Color(0xffe0e0e0),
      error: AppColors.error,
      onError: AppColors.white,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      textTheme: TextStyles.textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
    );
  }

  static ThemeData get dark {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      primaryContainer: _darkSurfaceContainerHigh,
      onPrimaryContainer: AppColors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.white,
      secondaryContainer: Color(0xff5c3d2a),
      onSecondaryContainer: Color(0xffffe0d0),
      surface: AppColors.primary,
      onSurface: AppColors.white,
      surfaceContainerHighest: _darkSurfaceContainerHigh,
      surfaceContainer: _darkSurfaceContainer,
      onSurfaceVariant: _darkOnSurfaceVariant,
      outline: _darkOutline,
      outlineVariant: _darkOutlineVariant,
      error: AppColors.error,
      onError: AppColors.white,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      textTheme: TextStyles.textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
    );
  }
}
