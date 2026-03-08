import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
  Future<UserModel> loginWithGoogle(String idToken);
  Future<UserModel> loginWithApple(String idToken);
  Future<void> requestPasswordResetOtp(String email);
  Future<void> resetPasswordWithOtp(String email, String otp, String newPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      final raw = response.data;
      if (raw is! Map<String, dynamic>) {
        throw ServerException('Invalid response format');
      }
      final data = raw['data'];
      if (data is! Map<String, dynamic>) {
        throw ServerException('Invalid response format');
      }
      final token = data['token']?.toString();
      if (token == null || token.isEmpty) {
        throw ServerException('No token in response');
      }
      final user = UserModel.fromJson(data);
      return UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        token: token,
        address: user.address,
        visa: user.visa,
        image: user.image,
      );
    } on DioException catch (e) {
      throw _mapDioException(e, 'Login failed');
    }
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.register,
        data: {'email': email, 'password': password, 'name': name},
      );
      final raw = response.data;
      if (raw is! Map<String, dynamic>) {
        throw ServerException('Invalid response format');
      }
      final data = raw['data'];
      if (data is! Map<String, dynamic>) {
        return UserModel.fromJson(raw);
      }
      final token = data['token']?.toString();
      final user = UserModel.fromJson(data);
      if (token != null && token.isNotEmpty) {
        return UserModel(
          id: user.id,
          email: user.email,
          name: user.name,
          token: token,
          address: user.address,
          visa: user.visa,
          image: user.image,
        );
      }
      return user;
    } on DioException catch (e) {
      throw _mapDioException(e, 'Registration failed');
    }
  }

  @override
  Future<UserModel> loginWithGoogle(String idToken) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.authGoogle,
        data: {'idToken': idToken},
      );
      final raw = response.data;
      if (raw is! Map<String, dynamic>) {
        throw ServerException('Invalid response format');
      }
      final data = raw['data'] ?? raw;
      final map = data is Map<String, dynamic> ? data : null;
      if (map == null) throw ServerException('Invalid response format');
      final token = map['token']?.toString() ?? raw['token']?.toString();
      final user = UserModel.fromJson(map);
      if (token != null && token.isNotEmpty) {
        return UserModel(
          id: user.id,
          email: user.email,
          name: user.name,
          token: token,
          address: user.address,
          visa: user.visa,
          image: user.image,
        );
      }
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 || e.response?.statusCode == 501) {
        throw ServerException('Social login will be available when API is connected');
      }
      throw _mapDioException(e, 'Google sign-in failed');
    }
  }

  @override
  Future<UserModel> loginWithApple(String idToken) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.authApple,
        data: {'idToken': idToken},
      );
      final raw = response.data;
      if (raw is! Map<String, dynamic>) {
        throw ServerException('Invalid response format');
      }
      final data = raw['data'] ?? raw;
      final map = data is Map<String, dynamic> ? data : null;
      if (map == null) throw ServerException('Invalid response format');
      final token = map['token']?.toString() ?? raw['token']?.toString();
      final user = UserModel.fromJson(map);
      if (token != null && token.isNotEmpty) {
        return UserModel(
          id: user.id,
          email: user.email,
          name: user.name,
          token: token,
          address: user.address,
          visa: user.visa,
          image: user.image,
        );
      }
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 || e.response?.statusCode == 501) {
        throw ServerException('Social login will be available when API is connected');
      }
      throw _mapDioException(e, 'Apple sign-in failed');
    }
  }

  @override
  Future<void> requestPasswordResetOtp(String email) async {
    try {
      await _dio.post(
        ApiEndpoints.forgetPasswordRequestOtp,
        data: {'email': email.trim()},
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 || e.response?.statusCode == 501) {
        throw ServerException('Forget password will be available when API is connected');
      }
      throw _mapDioException(e, 'Failed to send OTP');
    }
  }

  @override
  Future<void> resetPasswordWithOtp(String email, String otp, String newPassword) async {
    try {
      await _dio.post(
        ApiEndpoints.forgetPasswordVerifyOtp,
        data: {
          'email': email.trim(),
          'otp': otp.trim(),
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 || e.response?.statusCode == 501) {
        throw ServerException('Forget password will be available when API is connected');
      }
      throw _mapDioException(e, 'Failed to reset password');
    }
  }

  Never _mapDioException(DioException e, String fallback) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException(
          'Connection timeout. Please check your network.',
          e,
        );
      case DioExceptionType.connectionError:
        throw NetworkException(
          'No internet connection. Please check your network.',
          e,
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final msg = _extractMessage(e) ?? fallback;
        if (statusCode == 401) {
          throw AuthException(msg, e);
        }
        throw ServerException(
          msg,
          statusCode: statusCode,
          originalException: e,
        );
      default:
        final msg = _extractMessage(e) ?? fallback;
        if (e.type == DioExceptionType.unknown &&
            e.error?.toString().toLowerCase().contains('socket') == true) {
          throw NetworkException('Network error. Please try again.', e);
        }
        throw ServerException(msg, statusCode: e.response?.statusCode, originalException: e);
    }
  }

  String? _extractMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ??
          data['error'] as String? ??
          data['msg'] as String?;
    }
    return e.message;
  }
}
