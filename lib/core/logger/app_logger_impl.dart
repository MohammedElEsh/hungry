import 'package:flutter/foundation.dart';

import 'app_logger_interface.dart';

/// Default logger: debug prints in debug mode; in release, [onReleaseError] is called for e/w.
class AppLoggerImpl implements AppLoggerInterface {
  AppLoggerImpl({void Function(String message, Object? error, StackTrace? stack)? onReleaseError})
      : _onReleaseError = onReleaseError;

  final void Function(String message, Object? error, StackTrace? stack)? _onReleaseError;

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
    if (kDebugMode) {
      debugPrint('ℹ️ [INFO] $message');
    }
  }

  @override
  void w(String message) {
    if (kDebugMode) {
      debugPrint('⚠️ [WARN] $message');
    }
    _onReleaseError?.call(message, null, null);
  }

  @override
  void e(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('❌ [ERROR] $message');
      if (error != null) debugPrint('Error: $error');
      if (stackTrace != null) debugPrint('Stack: $stackTrace');
    }
    _onReleaseError?.call(message, error, stackTrace);
  }
}
