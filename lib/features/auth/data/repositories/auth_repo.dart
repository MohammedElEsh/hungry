import 'package:dio/dio.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../models/user_model.dart';
import 'dart:io';

class AuthRepo {
  final ApiService apiService = ApiService();

  /// login
  Future<UserModel> login(String email, String password) async {
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
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post('/register', {
        'name': name,
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

  /// get profile data
  Future<UserModel?> getProfileData() async {
    try {
      final response = await apiService.get('/profile');
      if (response != null && response['data'] != null) {
        return UserModel.fromJson(response['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// update profile
  Future<UserModel> updateProfileData({
    required String name,
    required String email,
    String? phone,
    String? address,
    File? image,
  }) async {
    try {
      final response = await apiService.post('/update-profile', {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
      });
      final data = response['data'];

      return UserModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// logout
  Future<void> logout() async {
    try {
      await apiService.post('/logout', {});
      await PrefHelper.removeToken();
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
