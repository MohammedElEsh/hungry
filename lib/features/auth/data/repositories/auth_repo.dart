import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/token_provider.dart';
import '../../../../core/utils/pref_helper.dart';
import '../models/user_model.dart';

class AuthRepo {
  // Singleton pattern
  static final AuthRepo _instance = AuthRepo._internal();
  factory AuthRepo() => _instance;
  AuthRepo._internal();

  final ApiService apiService = ApiService();
  bool _isGuest = false;
  UserModel? currentUser;

  /// مزامنة المستخدم بعد تسجيل الدخول عبر AuthCubit (ليعمل البروفايل والهوم بشكل صحيح)
  void setUserFromLogin(UserModel user) {
    currentUser = user;
    _isGuest = false;
  }

  /// login — POST {{base_url}}/login with JSON { email, password }
  /// Response: { data: { token, id?, email?, name?, ... } } or { token, user: {...} }
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await apiService.post(ApiEndpoints.login, {
        'email': email.trim(),
        'password': password,
      });

      if (response == null) {
        throw ApiError(message: 'Invalid response format');
      }
      final map = response is Map<String, dynamic>
          ? response
          : (response is Map ? Map<String, dynamic>.from(response) : null);
      if (map == null) {
        throw ApiError(message: 'Invalid response format');
      }

      String? token = map['data'] is Map
          ? (map['data'] as Map)['token']?.toString()
          : null;
      token ??= map['token']?.toString();
      if (token == null || token.isEmpty) {
        throw ApiError(message: 'No token in response');
      }

      final data = map['data'] is Map
          ? Map<String, dynamic>.from(map['data'] as Map)
          : map;
      final userMap = Map<String, dynamic>.from(data);
      if (!userMap.containsKey('token')) userMap['token'] = token;
      final user = UserModel.fromJson(userMap);
      final userWithToken = UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        token: token,
        address: user.address,
        visa: user.visa,
        image: user.image,
      );
      await PrefHelper.saveToken(token);
      GetIt.instance<TokenProvider>().setToken(token);
      await PrefHelper.setGuestMode(false);
      _isGuest = false;
      currentUser = userWithToken;
      return userWithToken;
    } on DioException catch (e) {
      final err = ApiExceptions.handleError(e);
      throw ApiError(message: err.message);
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError(message: e.toString());
    }
  }

  /// register — API uses formdata (name, email, phone, password, image optional); we send JSON.
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await apiService.post(ApiEndpoints.register, {
        'name': name,
        'email': email,
        'password': password,
        if (phone != null && phone.isNotEmpty) 'phone': phone,
      });

      if (response is! Map<String, dynamic>) {
        throw ApiError(message: 'Invalid response format');
      }
      final data = response['data'];
      final Map<String, dynamic> userMap = data is Map<String, dynamic>
          ? Map<String, dynamic>.from(data)
          : Map<String, dynamic>.from(response);
      final token = userMap['token']?.toString();
      if (token == null || token.isEmpty) {
        throw ApiError(message: 'No token in response');
      }
      final user = UserModel.fromJson(userMap);
      final userWithToken = UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        token: token,
        address: user.address,
        visa: user.visa,
        image: user.image,
      );
      await PrefHelper.saveToken(token);
      GetIt.instance<TokenProvider>().setToken(token);
      await PrefHelper.setGuestMode(false);
      _isGuest = false;
      currentUser = userWithToken;
      return userWithToken;
    } on DioException catch (e) {
      final err = ApiExceptions.handleError(e);
      throw ApiError(message: err.message);
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError(message: e.toString());
    }
  }

  /// get profile data — GET /profile (bearer)
  /// API response: { "code": 200, "message": "PROFILE DATA", "data": { "name", "email", "image", "address", "Visa" } }
  Future<UserModel?> getProfileData() async {
    try {
      final token = await PrefHelper.getToken();
      if (token == null || token.isEmpty) return null;

      final response = await apiService.get(ApiEndpoints.profile);
      if (response == null) return currentUser;
      final Map<String, dynamic>? map = response is Map
          ? Map<String, dynamic>.from(response)
          : null;
      if (map == null || map.isEmpty) return currentUser;

      // Extract profile object from data or user key (API: { code, message, data: { name, email, image, address, Visa } })
      final data = map['data'];
      Map<String, dynamic> userMap;
      if (data is Map) {
        userMap = Map<String, dynamic>.from(data);
      } else if (map['user'] is Map) {
        userMap = Map<String, dynamic>.from(map['user'] as Map);
      } else if (map['profile'] is Map) {
        userMap = Map<String, dynamic>.from(map['profile'] as Map);
      } else {
        userMap = map;
      }
      if (userMap.isEmpty) return currentUser;

      final user = UserModel.fromJson(userMap);
      final id = user.id.isNotEmpty ? user.id : (currentUser?.id ?? user.email);
      final preservedToken = currentUser?.token ?? token;
      currentUser = UserModel(
        id: id,
        email: user.email.isNotEmpty ? user.email : (currentUser?.email ?? ''),
        name: user.name ?? currentUser?.name,
        token: preservedToken,
        address: user.address ?? currentUser?.address,
        visa: user.visa ?? currentUser?.visa,
        image: user.image ?? currentUser?.image,
      );
      return currentUser!;
    } on DioException catch (e) {
      final err = ApiExceptions.handleError(e);
      throw ApiError(message: err.message);
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError(message: e.toString());
    }
  }

  /// update profile — POST /update-profile (bearer), formdata: name, email, phone, image, address
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
        if (phone != null && phone.isNotEmpty) 'phone': phone,
        if (address != null && address.isNotEmpty) 'address': address,
        if (visa != null && visa.isNotEmpty) 'visa': visa,
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split(RegExp(r'[/\\]')).last,
          ),
      });

      final response = await apiService.post(ApiEndpoints.updateProfile, formData);
      if (response is! Map<String, dynamic>) {
        throw ApiError(message: 'Invalid response format');
      }
      final data = response['data'];
      final Map<String, dynamic> userMap = data is Map<String, dynamic>
          ? Map<String, dynamic>.from(data)
          : Map<String, dynamic>.from(response);
      final updatedUser = UserModel.fromJson(userMap);
      currentUser = updatedUser;
      return updatedUser;
    } on DioException catch (e) {
      final err = ApiExceptions.handleError(e);
      throw ApiError(message: err.message);
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError(message: e.toString());
    }
  }

  /// logout
  Future<void> logout() async {
    try {
      // If user is guest, just clear local state
      if (_isGuest) {
        await PrefHelper.removeToken();
        GetIt.instance<TokenProvider>().clearToken();
        await PrefHelper.setGuestMode(false);

        _isGuest = false;
        currentUser = null;
        return;
      }

      // If user is logged in, call API then clear state
      await apiService.post(ApiEndpoints.logout, {});
      await PrefHelper.removeToken();
      GetIt.instance<TokenProvider>().clearToken();
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
