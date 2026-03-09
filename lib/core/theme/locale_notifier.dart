import 'package:flutter/material.dart';

import '../storage/app_preferences.dart';

/// Notifies app when locale/language changes. Keeps UI in sync with saved preference.
class LocaleNotifier extends ChangeNotifier {
  LocaleNotifier(this._prefs);

  final AppPreferences _prefs;
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> init() async {
    final code = await _prefs.getLocale();
    _locale = code == 'ar' ? const Locale('ar') : const Locale('en');
    notifyListeners();
  }

  Future<void> setLocale(Locale value) async {
    await _prefs.setLocale(value.languageCode);
    _locale = value;
    notifyListeners();
  }
}
