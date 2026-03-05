import 'package:hive_flutter/hive_flutter.dart';

/// Hive init (no local datasources / no boxes used).
class HiveManager {
  static Future<void> init() async {
    await Hive.initFlutter();
  }
}
