/// Application string constants.
abstract class AppStrings {
  AppStrings._();

  static const String appName = 'Hungry';

  // Auth
  static const String login = 'Login';
  static const String signUp = 'Sign Up';
  static const String logout = 'Logout';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String forgotPassword = 'Forgot Password?';

  // General
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String ok = 'OK';

  // Home
  static const String home = 'Home';
  static const String categories = 'Categories';

  // Cart
  static const String cart = 'Cart';
  static const String addToCart = 'Add to Cart';
  static const String emptyCart = 'Your cart is empty';
  static const String checkout = 'Checkout';

  // Orders
  static const String orders = 'Orders';
  static const String orderDetails = 'Order Details';
  static const String noOrders = 'No orders yet';

  // Profile
  static const String profile = 'Profile';

  // Errors
  static const String networkError = 'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String cacheError = 'Failed to load cached data.';
  static const String authError = 'Authentication failed.';
}
