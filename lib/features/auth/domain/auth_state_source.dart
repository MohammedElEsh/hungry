import 'entities/user_entity.dart';

/// Single source of truth for current user / is logged in / is guest.
/// Used by router redirect, splash, and repositories that need to sync after login.
abstract class AuthStateSource {
  UserEntity? get currentUser;
  bool get isLoggedIn;
  bool get isGuest;
  void setUserFromLogin(UserEntity user);
}
