import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../data/models/cart_model.dart';
import '../../data/repositories/cart_repo.dart';
import '../widgets/cart_items_list.dart';
import '../widgets/cart_summary.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
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

  Future<void> _removeItem(int itemId) async {
    setState(() => _isLoading = true);
    try {
      await _cartRepo.removeCartItem(itemId);
      await _loadCart();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Item removed from cart')));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to remove: $e')));
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
    if (_error != null && !_isLoading) {
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
    final items = _cart?.items ??
        [
          for (int i = 0; i < 3; i++)
            CartDisplayItem(
              itemId: -(i + 1),
              productId: 0,
              name: 'Loading item',
              image: null,
              quantity: 1,
              price: '0',
              spicy: 0,
              toppings: const [],
              sideOptions: const [],
            ),
        ];
    return Scaffold(
      body: Skeletonizer(
        enabled: _isLoading,
        effect: ShimmerEffect(
          baseColor: Colors.grey.shade300.withOpacity(0.3),
          highlightColor: Colors.grey.shade100.withOpacity(0.1),
          duration: const Duration(milliseconds: 1200),
        ),
        child: Column(
          children: [
            CartItemsList(
              items: items,
              onRemove: _removeItem,
            ),
            Gap(10.h),
            CartSummary(totalPrice: _cart?.totalPrice ?? '0'),
            Gap(10.h),
          ],
        ),
      ),
    );
  }
}
