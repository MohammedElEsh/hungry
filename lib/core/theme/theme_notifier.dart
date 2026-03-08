import 'package:flutter/material.dart';

import '../storage/app_preferences.dart';

/// Notifies app when theme mode changes.
class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier(this._prefs);

  final AppPreferences _prefs;
  ThemeMode? _themeMode;

  ThemeMode get themeMode => _themeMode ?? ThemeMode.light;

  Future<void> init() async {
    _themeMode = await _prefs.getThemeMode();
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setThemeMode(mode);
    _themeMode = mode;
    notifyListeners();
  }
}
