import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/token_provider.dart';
import '../../../../core/router/auth_refresh_notifier.dart';
import '../../../../core/storage/token_storage.dart';
import '../../../../core/utils/pref_helper.dart';
import '../../domain/auth_state_source.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

class AuthRepo implements AuthStateSource {
  AuthRepo(this._tokenStorage, this._tokenProvider, this._authRefreshNotifier);

  final TokenStorage _tokenStorage;
  final TokenProvider _tokenProvider;
  final AuthRefreshNotifier _authRefreshNotifier;
  final ApiService apiService = ApiService();
  bool _isGuest = false;
  UserModel? _currentUser;

  @override
  UserEntity? get currentUser =>
      _currentUser != null ? _userModelToEntity(_currentUser!) : null;

  /// For profile and other code that need the full model (e.g. image URL).
  UserModel? get currentUserModel => _currentUser;

  @override
  void setUserFromLogin(UserEntity user) {
    _currentUser = _userEntityToModel(user);
    _isGuest = false;
  }

  void _setUserFromLoginModel(UserModel user) {
    _currentUser = user;
    _isGuest = false;
  }

  static UserEntity _userModelToEntity(UserModel m) => UserEntity(
        id: m.id,
        email: m.email,
        name: m.name,
        token: m.token,
        address: m.address,
        visa: m.visa,
        image: m.image,
      );

  static UserModel _userEntityToModel(UserEntity e) => UserModel(
        id: e.id,
        email: e.email,
        name: e.name,
        token: e.token,
        address: e.address,
        visa: e.visa,
        image: e.image,
      );

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
      await _tokenStorage.saveToken(token);
      _tokenProvider.setToken(token);
      await PrefHelper.setGuestMode(false);
      _setUserFromLoginModel(userWithToken);
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
      await _tokenStorage.saveToken(token);
      _tokenProvider.setToken(token);
      await PrefHelper.setGuestMode(false);
      _setUserFromLoginModel(userWithToken);
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
      final token = await _tokenStorage.getToken();
      if (token == null || token.isEmpty) return null;

      final response = await apiService.get(ApiEndpoints.profile);
      if (response == null) return _currentUser;
      final Map<String, dynamic>? map = response is Map
          ? Map<String, dynamic>.from(response)
          : null;
      if (map == null || map.isEmpty) return _currentUser;

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
      if (userMap.isEmpty) return _currentUser;

      final user = UserModel.fromJson(userMap);
      final id = user.id.isNotEmpty ? user.id : (_currentUser?.id ?? user.email);
      final preservedToken = _currentUser?.token ?? token;
      _currentUser = UserModel(
        id: id,
        email: user.email.isNotEmpty ? user.email : (currentUser?.email ?? ''),
        name: user.name ?? _currentUser?.name,
        token: preservedToken,
        address: user.address ?? _currentUser?.address,
        visa: user.visa ?? _currentUser?.visa,
        image: user.image ?? _currentUser?.image,
      );
      return _currentUser!;
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
      _currentUser = updatedUser;
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
        await _tokenStorage.deleteToken();
        _tokenProvider.clearToken();
        await PrefHelper.setGuestMode(false);

        _isGuest = false;
        _currentUser = null;
        return;
      }

      // If user is logged in, call API then clear state
      await apiService.post(ApiEndpoints.logout, {});
      await _tokenStorage.deleteToken();
      _tokenProvider.clearToken();
      await PrefHelper.setGuestMode(false);

      _isGuest = false;
      _currentUser = null;
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
        _currentUser = null;
        return null;
      }

      // Try to get token
      final token = await _tokenStorage.getToken();

      if (token == null) {
        return null;
      }

      // Try to get user profile
      final user = await getProfileData();

      if (user != null) {
        _currentUser = user;
        _isGuest = false;
      }

      return user;
    } catch (_) {
      return null;
    }
  }

  /// CONTINUE AS GUEST
  Future<void> continueAsGuest() async {
    await _tokenStorage.deleteToken();
    await PrefHelper.setGuestMode(true);

    _isGuest = true;
    _currentUser = null;
    _authRefreshNotifier.notifyAuthChanged();
  }

  @override
  bool get isLoggedIn => !_isGuest && _currentUser != null;

  @override
  bool get isGuest => _isGuest;
}
