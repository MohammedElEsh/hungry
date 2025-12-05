import 'package:go_router/go_router.dart';
import 'package:hungry/features/auth/presentation/views/login_view.dart';
import 'package:hungry/features/cart/presentation/views/cart_view.dart';
import 'package:hungry/features/splash/splash_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/checkout/presentation/views/checkout_view.dart';
import '../../features/product/presentation/views/product_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../components/custom_bottom_nav_bar.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kLoginView = '/loginView';
  static const kSignupView = '/signupView';
  static const kHomeView = '/homeView';
  static const kProductView = '/productView';
  static const kCheckoutView = '/checkoutView';
  static const kCartView = '/cartView';
  static const kProfileView = '/profileView';

  static final GoRouter router = GoRouter(
    initialLocation: kSplashView,
    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(path: kLoginView, builder: (context, state) => const LoginView()),
      GoRoute(
        path: kSignupView,
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const CustomBottomNavBar(),
      ),
      GoRoute(
        path: kProductView,
        builder: (context, state) => const ProductView(),
      ),
      GoRoute(
        path: kCheckoutView,
        builder: (context, state) => const CheckoutView(),
      ),
      GoRoute(path: kCartView, builder: (context, state) => const CartView()),
      GoRoute(
        path: kProfileView,
        builder: (context, state) => const ProfileView(),
      ),
    ],
  );
}
