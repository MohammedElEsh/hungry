import 'package:dio/dio.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../models/user_model.dart';
import 'dart:io';

class AuthRepo {
  // Singleton pattern
  static final AuthRepo _instance = AuthRepo._internal();
  factory AuthRepo() => _instance;
  AuthRepo._internal();

  final ApiService apiService = ApiService();
  bool _isGuest = false;
  UserModel? currentUser;

  /// login
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await apiService.post('/login', {
        'email': email,
        'password': password,
      });

      final data = response['data'];
      final user = UserModel.fromJson(data);

      await PrefHelper.saveToken(user.token!);
      await PrefHelper.setGuestMode(false);

      _isGuest = false;
      currentUser = user;

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
      await PrefHelper.saveToken(user.token!);
      await PrefHelper.setGuestMode(false);

      _isGuest = false;
      currentUser = user;

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
      final token = await PrefHelper.getToken();
      if (token == null) return null;

      final response = await apiService.get('/profile');

      if (response != null && response['data'] != null) {
        final user = UserModel.fromJson(response['data']);
        currentUser = user;
        return user;
      }

      return null;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// update profile
  Future<UserModel> updateProfileData({
    required String name,
    required String email,
    String? phone,
    String? address,
    String? visa,
    File? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        if (visa != null && visa.isNotEmpty) 'Visa': visa,
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      final response = await apiService.post('/update-profile', formData);

      final data = response['data'];
      final updatedUser = UserModel.fromJson(data);

      currentUser = updatedUser;

      return updatedUser;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// logout
  Future<void> logout() async {
    try {
      // If user is guest, just clear local state
      if (_isGuest) {
        await PrefHelper.removeToken();
        await PrefHelper.setGuestMode(false);

        _isGuest = false;
        currentUser = null;
        return;
      }

      // If user is logged in, call API then clear state
      await apiService.post('/logout', {});
      await PrefHelper.removeToken();
      await PrefHelper.setGuestMode(false);

      _isGuest = false;
      currentUser = null;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// AUTO LOGIN
  Future<UserModel?> autoLogin() async {
    try {
      // Check if user is in guest mode
      final isGuestMode = await PrefHelper.isGuestMode();
      if (isGuestMode) {
        _isGuest = true;
        currentUser = null;
        return null;
      }

      // Try to get token
      final token = await PrefHelper.getToken();

      if (token == null) {
        return null;
      }

      // Try to get user profile
      final user = await getProfileData();

      if (user != null) {
        currentUser = user;
        _isGuest = false;
      }

      return user;
    } catch (_) {
      return null;
    }
  }

  /// CONTINUE AS GUEST
  Future<void> continueAsGuest() async {
    await PrefHelper.removeToken();
    await PrefHelper.setGuestMode(true);

    _isGuest = true;
    currentUser = null;
  }

  // UserModel? get currentUserModel => currentUser;
  // bool get isGuestUser => _isGuest && currentUser == null;
  bool get isLoggedIn => !_isGuest && currentUser != null;
  bool get isGuest => _isGuest;
}
