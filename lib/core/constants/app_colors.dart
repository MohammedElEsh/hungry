import 'dart:ui';

/// Application color constants.
abstract class AppColors {
  AppColors._();

  // Main theme colors
  static const Color primary = Color(0xff121223);
  static const Color secondary = Color(0xfffd7522);
  static const Color tertiary = Color(0xff3C2F2F);
  static const Color surface = Color(0xffeef3f8);
  static const Color surfaceVariant = Color(0xffb3b8c9);
  static const Color background = Color(0xffe5eff8);

  // Aliases for backward compatibility
  static const Color third = tertiary;
  static const Color forth = surface;
  static const Color fifth = surfaceVariant;

  // Neutral colors
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color grey = Color(0xff9e9e9e);

  // Feedback colors
  static const Color error = Color(0xffd32f2f);
  static const Color success = Color(0xff388e3c);
  static const Color warning = Color(0xffffa000);
  static const Color info = Color(0xff1976d2);
}
