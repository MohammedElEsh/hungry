import 'package:hive_flutter/hive_flutter.dart';

/// Hive init and box registration.
class HiveManager {
  static Future<void> init() async {
    await Hive.initFlutter();
    // app_settings box opened lazily by AppPreferencesImpl
  }
}
