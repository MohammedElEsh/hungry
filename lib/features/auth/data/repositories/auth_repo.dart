import 'package:dio/dio.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../models/user_model.dart';

class AuthRepo {
  final ApiService apiService = ApiService();

  /// login
  Future<dynamic> login(String email, String password) async {
    try {
      final response = await apiService.post('/login', {
        'email': email,
        'password': password,
      });

      final data = response['data'];

      final user = UserModel.fromJson(data);

      await PrefHelper.saveToken(user.token);

      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// register
  Future<dynamic> register(UserModel user) async {
    try {
      final response = await apiService.post('/register', user.toJson());
      return response;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    } catch (_) {
      return ApiError(message: "Unexpected error");
    }
  }

  /// get profile data
  Future<UserModel?> getProfileData() async {
    try {
      final response = await apiService.get('/profile');
      if (response != null && response['data'] != null) {
        return UserModel.fromJson(response['data']);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// update profile
  Future<dynamic> updateProfileData(UserModel user) async {
    try {
      final response = await apiService.put('/profile/update', user.toJson());
      return response;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    } catch (_) {
      return ApiError(message: "Unexpected error");
    }
  }

  /// logout
  Future<dynamic> logout() async {
    try {
      final response = await apiService.post('/logout', {});
      await PrefHelper.removeToken(); // ✅ امسح التوكن بعد اللوج أوت
      return response;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    } catch (_) {
      return ApiError(message: "Unexpected error");
    }
  }
}
