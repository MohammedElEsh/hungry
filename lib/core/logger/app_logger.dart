import 'package:flutter/foundation.dart';

import 'app_logger_interface.dart';

/// Static access to the app logger. Set [instance] after DI init so tests can inject a no-op or mock.
abstract class AppLogger {
  static AppLoggerInterface? _instance;

  static set instance(AppLoggerInterface? value) => _instance = value;

  static AppLoggerInterface get _delegate => _instance ?? _fallback;

  static final AppLoggerInterface _fallback = _FallbackLogger();

  static void d(String message, [Object? error, StackTrace? stackTrace]) {
    _delegate.d(message, error, stackTrace);
  }

  static void i(String message) => _delegate.i(message);

  static void w(String message) => _delegate.w(message);

  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    _delegate.e(message, error, stackTrace);
  }
}

class _FallbackLogger implements AppLoggerInterface {
  @override
  void d(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('🐛 [DEBUG] $message');
      if (error != null) debugPrint('Error: $error');
      if (stackTrace != null) debugPrint('Stack: $stackTrace');
    }
  }

  @override
  void i(String message) {
    if (kDebugMode) debugPrint('ℹ️ [INFO] $message');
  }

  @override
  void w(String message) {
    if (kDebugMode) debugPrint('⚠️ [WARN] $message');
  }

  @override
  void e(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('❌ [ERROR] $message');
      if (error != null) debugPrint('Error: $error');
      if (stackTrace != null) debugPrint('Stack: $stackTrace');
    }
  }
}
