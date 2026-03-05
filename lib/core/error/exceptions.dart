/// Base exception class for app-specific exceptions.
abstract class AppException implements Exception {
  final String message;
  final dynamic originalException;

  const AppException(this.message, [this.originalException]);

  @override
  String toString() => message;
}

/// Thrown when a network request fails.
class NetworkException extends AppException {
  const NetworkException([super.message = 'Network request failed', super.originalException]);
}

/// Thrown when server returns an error response.
class ServerException extends AppException {
  final int? statusCode;

  const ServerException(String message, {this.statusCode, dynamic originalException})
      : super(message, originalException);
}

/// Thrown when local cache/Hive operations fail.
class CacheException extends AppException {
  const CacheException([super.message = 'Cache operation failed', super.originalException]);
}

/// Thrown when authentication fails.
class AuthException extends AppException {
  const AuthException([super.message = 'Authentication failed', super.originalException]);
}
