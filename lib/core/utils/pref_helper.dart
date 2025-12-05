import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String tokenKey = 'auth_token';
  static const String guestModeKey = 'guest_mode';

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  static Future<void> setGuestMode(bool isGuest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(guestModeKey, isGuest);
  }

  static Future<bool> isGuestMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(guestModeKey) ?? false;
  }
}
