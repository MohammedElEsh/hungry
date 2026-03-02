import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:hungry/features/auth/data/models/user_model.dart';
import 'package:hungry/features/auth/data/repositories/auth_repo.dart';
import 'package:hungry/features/cart/data/models/cart_model.dart';
import 'package:hungry/features/cart/data/repositories/cart_repo.dart';
import 'package:hungry/features/checkout/presentation/widgets/payment_action_section.dart';
import 'package:hungry/features/orders/data/repositories/order_repo.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/order_summary_section.dart';
import '../widgets/payment_methods_section.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final CartRepo _cartRepo = CartRepo();
  final AuthRepo _authRepo = AuthRepo();
  final OrderRepo _orderRepo = OrderRepo();
  CartModel? _cart;
  UserModel? _profile;
  bool _isLoading = true;
  bool _isPaying = false;
  String? _error;

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      CartModel cart;
      try {
        cart = await _cartRepo.getCart();
      } catch (_) {
        cart = CartModel(totalPrice: '0', items: []);
      }
      UserModel? profile;
      if (!_authRepo.isGuest) {
        try {
          profile = await _authRepo.getProfileData();
        } catch (_) {
          profile = null;
        }
      }
      if (mounted) {
        setState(() {
          _cart = cart;
          _profile = profile;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _handlePayNow() async {
    if (_isPaying || _cart == null) return;
    if (_authRepo.isGuest) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please sign in to place an order'),
        ),
      );
      return;
    }
    if (_cart!.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty. Add items before checkout.'),
        ),
      );
      return;
    }
    setState(() => _isPaying = true);
    try {
      await _orderRepo.createOrder(_cart!.items);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order placed successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        final message = e is ApiError ? e.message : e.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order failed: $message')),
        );
      }
    } finally {
      if (mounted) setState(() => _isPaying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null && !_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!, textAlign: TextAlign.center),
              Gap(16.h),
              TextButton(onPressed: _loadData, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }
    final cart = _cart ?? CartModel(totalPrice: '0', items: []);
    return Scaffold(
      body: Skeletonizer(
        enabled: _isLoading,
        effect: ShimmerEffect(
          baseColor: Colors.grey.shade300.withOpacity(0.3),
          highlightColor: Colors.grey.shade100.withOpacity(0.1),
          duration: const Duration(milliseconds: 1200),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(80.h),
              Text("Order Summary", style: AppTextStyles.bodyBrown),
              OrderSummary(cart: cart),
              Gap(60.h),
              Text("Payment Methods", style: AppTextStyles.bodyBrown),
              Gap(20.h),
              PaymentMethods(savedCardDisplay: _profile?.visa),
              Gap(115.h),
              PaymentActionSection(
                totalPrice: cart.totalPrice,
                onPayNow: _handlePayNow,
                isLoading: _isPaying,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
