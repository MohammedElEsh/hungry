/// Application logger interface. Implementations can log to console, file, or crash reporting.
/// Do not log sensitive data (tokens, passwords).
abstract class AppLoggerInterface {
  void d(String message, [Object? error, StackTrace? stackTrace]);
  void i(String message);
  void w(String message);
  void e(String message, [Object? error, StackTrace? stackTrace]);
}
