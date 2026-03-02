import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/cart/data/models/cart_model.dart';
import 'package:hungry/features/cart/data/repositories/cart_repo.dart';
import 'package:hungry/features/checkout/presentation/widgets/payment_action_section.dart';
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
  CartModel? _cart;
  bool _isLoading = true;
  String? _error;

  Future<void> _loadCart() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final cart = await _cartRepo.getCart();
      if (mounted) {
        setState(() {
          _cart = cart;
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
    _loadCart();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!, textAlign: TextAlign.center),
              Gap(16.h),
              TextButton(onPressed: _loadCart, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(80.h),
            Text("Order Summary", style: AppTextStyles.bodyBrown),
            OrderSummary(cart: _cart!),
            Gap(60.h),
            Text("Payment Methods", style: AppTextStyles.bodyBrown),
            Gap(20.h),
            PaymentMethods(),
            Gap(115.h),
            PaymentActionSection(totalPrice: _cart!.totalPrice),
          ],
        ),
      ),
    );
  }
}
