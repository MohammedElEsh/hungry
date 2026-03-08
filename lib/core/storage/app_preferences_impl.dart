import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_preferences.dart';

const _boxName = 'app_settings';
const _localeKey = 'locale';
const _themeModeKey = 'theme_mode';
const _guestModeKey = 'guest_mode';
const _onboardingSeenKey = 'onboarding_seen';

class AppPreferencesImpl implements AppPreferences {
  Box<String>? _box;

  Future<Box<String>> _getBox() async {
    _box ??= await Hive.openBox<String>(_boxName);
    return _box!;
  }

  @override
  Future<String?> getLocale() async {
    final box = await _getBox();
    return box.get(_localeKey);
  }

  @override
  Future<void> setLocale(String languageCode) async {
    final box = await _getBox();
    await box.put(_localeKey, languageCode);
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final box = await _getBox();
    final value = box.get(_themeModeKey, defaultValue: 'light');
    return switch (value) {
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.light,
    };
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    final box = await _getBox();
    final value = switch (mode) {
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
      _ => 'light',
    };
    await box.put(_themeModeKey, value);
  }

  @override
  Future<bool> isGuestMode() async {
    final box = await _getBox();
    return box.get(_guestModeKey, defaultValue: 'false') == 'true';
  }

  @override
  Future<void> setGuestMode(bool isGuest) async {
    final box = await _getBox();
    await box.put(_guestModeKey, isGuest.toString());
  }

  @override
  Future<bool> isOnboardingSeen() async {
    final box = await _getBox();
    return box.get(_onboardingSeenKey, defaultValue: 'false') == 'true';
  }

  @override
  Future<void> setOnboardingSeen(bool seen) async {
    final box = await _getBox();
    await box.put(_onboardingSeenKey, seen.toString());
  }
}
