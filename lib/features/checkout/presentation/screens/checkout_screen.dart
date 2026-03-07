import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_router.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/data/repositories/auth_repo.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../orders/data/repositories/order_repo.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/order_summary_section.dart';
import '../widgets/payment_action_section.dart';
import '../widgets/payment_methods_section.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  AuthRepo get _authRepo => sl<AuthRepo>();
  final OrderRepo _orderRepo = OrderRepo();
  UserModel? _profile;
  bool _isLoading = true;
  bool _isPaying = false;
  String? _error;

  Future<void> _loadProfile() async {
    if (!_authRepo.isGuest) {
      try {
        final profile = await _authRepo.getProfileData();
        if (mounted) setState(() => _profile = profile);
      } catch (_) {
        if (mounted) setState(() => _profile = null);
      }
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _handlePayNow(
    BuildContext context,
    CartCubit cartCubit,
    List<CartItemEntity> items,
  ) async {
    if (_isPaying) return;
    if (_authRepo.isGuest) {
      showErrorBanner(context, 'Please sign in to place an order');
      return;
    }
    if (items.isEmpty) {
      showErrorBanner(context, 'Your cart is empty. Add items before checkout.');
      return;
    }
    setState(() => _isPaying = true);
    try {
      await _orderRepo.createOrder(items);
      if (!context.mounted) return;
      cartCubit.clearCart();
      if (!context.mounted) return;
      showSuccessBanner(context, 'Order placed successfully');
      if (!context.mounted) return;
      context.go(AppRouter.kHomeView);
    } catch (e) {
      if (context.mounted) {
        final message = e is ApiError ? e.message : e.toString();
        showErrorBanner(context, 'Order failed: $message');
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
              TextButton(
                onPressed: () {
                  setState(() => _error = null);
                  _loadProfile();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        final items = cartState is CartLoaded ? cartState.items : <CartItemEntity>[];
        // Use API total when present; otherwise fall back to sum of items.
        final subtotal = cartState is CartLoaded && cartState.totalPriceFromApi != null && cartState.totalPriceFromApi!.isNotEmpty
            ? (double.tryParse(cartState.totalPriceFromApi!.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0)
            : items.fold(0.0, (s, i) => s + (i.price * i.quantity));

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
                  OrderSummarySection(subtotal: subtotal),
                  Gap(60.h),
                  Text("Payment Methods", style: AppTextStyles.bodyBrown),
                  Gap(20.h),
                  PaymentMethods(savedCardDisplay: _profile?.visa),
                  Gap(115.h),
                  PaymentActionSection(
                    totalPrice: subtotal.toStringAsFixed(2),
                    onPayNow: () => _handlePayNow(
                      context,
                      context.read<CartCubit>(),
                      items,
                    ),
                    isLoading: _isPaying,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
