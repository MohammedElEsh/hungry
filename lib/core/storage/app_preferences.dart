import 'package:flutter/material.dart';

/// App preferences (locale, theme, guest mode, onboarding).
/// Implemented with Hive for persistence.
abstract class AppPreferences {
  Future<String?> getLocale();
  Future<void> setLocale(String languageCode);

  Future<ThemeMode> getThemeMode();
  Future<void> setThemeMode(ThemeMode mode);

  Future<bool> isGuestMode();
  Future<void> setGuestMode(bool isGuest);

  Future<bool> isOnboardingSeen();
  Future<void> setOnboardingSeen(bool seen);
}
