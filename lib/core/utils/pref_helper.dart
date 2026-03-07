import 'package:shared_preferences/shared_preferences.dart';

/// Non-sensitive app preferences (guest mode, locale, theme, etc.).
/// For auth token use [TokenStorage] from DI.
class PrefHelper {
  static const String guestModeKey = 'guest_mode';
  static const String localeKey = 'locale';

  static Future<void> setGuestMode(bool isGuest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(guestModeKey, isGuest);
  }

  static Future<bool> isGuestMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(guestModeKey) ?? false;
  }

  static Future<void> setLocale(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(localeKey, languageCode);
  }

  static Future<String?> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(localeKey);
  }
}
