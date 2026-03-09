import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel?> getProfile();
  Future<ProfileModel> updateProfile(FormData formData);
  Future<void> changePassword(String currentPassword, String newPassword);
  Future<void> deleteAccount();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSourceImpl(this._dio);

  static Map<String, dynamic> _extractProfileMap(dynamic response) {
    if (response == null) return {};
    final Map<String, dynamic>? map =
        response is Map ? Map<String, dynamic>.from(response) : null;
    if (map == null || map.isEmpty) return {};

    final data = map['data'];
    if (data is Map) return Map<String, dynamic>.from(data);
    if (map['user'] is Map) return Map<String, dynamic>.from(map['user'] as Map);
    if (map['profile'] is Map) return Map<String, dynamic>.from(map['profile'] as Map);
    return map;
  }

  Never _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      throw NetworkException('Connection failed');
    }
    if (e.response?.statusCode == 401) {
      throw AuthException('Unauthorized');
    }
    if ((e.response?.statusCode ?? 0) >= 400) {
      final data = e.response?.data;
      final msg = (data is Map && data['message'] != null)
          ? data['message'].toString()
          : 'Server error';
      throw ServerException(msg, statusCode: e.response?.statusCode);
    }
    throw ServerException(e.message ?? 'Request failed');
  }

  @override
  Future<ProfileModel?> getProfile() async {
    try {
      final response = await _dio.get(ApiEndpoints.profile);
      final userMap = _extractProfileMap(response.data);
      if (userMap.isEmpty) return null;
      return ProfileModel.fromJson(userMap);
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<ProfileModel> updateProfile(FormData formData) async {
    try {
      final response = await _dio.post(ApiEndpoints.updateProfile, data: formData);
      final userMap = _extractProfileMap(response.data);
      if (userMap.isEmpty) throw ServerException('Invalid response format');
      return ProfileModel.fromJson(userMap);
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await _dio.post(ApiEndpoints.changePassword, data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      });
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 404 || statusCode == 501) {
        throw ServerException('change_password_not_available');
      }
      _handleDioException(e);
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _dio.delete(ApiEndpoints.deleteAccount);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 404 || statusCode == 501) {
        throw ServerException('delete_account_not_available');
      }
      _handleDioException(e);
    }
  }
}
