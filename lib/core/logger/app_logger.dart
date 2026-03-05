import 'package:flutter/foundation.dart';

/// Application logger - uses debugPrint in debug, no-op in release.
abstract class AppLogger {
  static void d(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('🐛 [DEBUG] $message');
      if (error != null) debugPrint('Error: $error');
      if (stackTrace != null) debugPrint('Stack: $stackTrace');
    }
  }

  static void i(String message) {
    if (kDebugMode) {
      debugPrint('ℹ️ [INFO] $message');
    }
  }

  static void w(String message) {
    if (kDebugMode) {
      debugPrint('⚠️ [WARN] $message');
    }
  }

  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('❌ [ERROR] $message');
      if (error != null) debugPrint('Error: $error');
      if (stackTrace != null) debugPrint('Stack: $stackTrace');
    }
  }
}
