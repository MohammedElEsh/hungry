import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Application text styles.
abstract class TextStyles {
  static TextTheme get textTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle get h1 => textTheme.headlineLarge!;
  static TextStyle get h2 => textTheme.headlineMedium!;
  static TextStyle get h3 => textTheme.headlineSmall!;
  static TextStyle get bodyLarge => textTheme.bodyLarge!;
  static TextStyle get bodyMedium => textTheme.bodyMedium!;
  static TextStyle get bodySmall => textTheme.bodySmall!;
  static TextStyle get labelLarge => textTheme.labelLarge!;
  static TextStyle get labelMedium => textTheme.labelMedium!;
}
