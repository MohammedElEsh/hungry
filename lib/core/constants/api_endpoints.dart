import '../config/app_config.dart';

/// API endpoint constants aligned with Sonic backend (SonicCollection.json).
abstract class ApiEndpoints {
  ApiEndpoints._();

  static String get baseUrl => AppConfig.baseUrl;

  // Auth
  static const String login = 'login';
  static const String register = 'register';
  static const String authGoogle = 'auth/google';
  static const String authApple = 'auth/apple';
  static const String logout = 'logout';
  static const String profile = 'profile';
  static const String updateProfile = 'update-profile';
  static const String changePassword = 'change-password';
  static const String deleteAccount = 'profile/delete';
  static const String forgetPasswordRequestOtp = 'auth/forget-password/request-otp';
  static const String forgetPasswordVerifyOtp = 'auth/forget-password/verify-otp';

  // Category
  static const String categories = 'categories';

  // Product
  static const String products = 'products';
  static String productById(String id) => 'products/$id';
  static const String toppings = 'toppings';
  static const String sideOptions = 'side-options';

  // Favorite
  static const String favorites = 'favorites';
  static const String toggleFavorite = 'toggle-favorite';

  // Order
  static const String orders = 'orders';
  static String orderById(String id) => 'orders/$id';

  // Cart
  static const String cart = 'cart';
  static const String cartAdd = 'cart/add';
  static String cartRemove(String itemId) => 'cart/remove/$itemId';
}
