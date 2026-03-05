import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_items_list.dart';
import '../widgets/cart_summary.dart';

/// Cart loaded state: CartItemWidget list + CartSummary. Uses the card-style cart item UI.
/// When [totalPriceFromApi] is set, shows that value (from API); otherwise falls back to sum of items.
class CartLoadedView extends StatelessWidget {
  final List<CartItemEntity> items;
  final String? totalPriceFromApi;
  final String? removingItemId;
  final VoidCallback onCheckout;

  const CartLoadedView({
    super.key,
    required this.items,
    this.totalPriceFromApi,
    this.removingItemId,
    required this.onCheckout,
  });

  String get _displayTotal {
    if (totalPriceFromApi != null && totalPriceFromApi!.isNotEmpty) {
      return totalPriceFromApi!;
    }
    final sum = items.fold<double>(0, (sum, i) => sum + (i.price * i.quantity));
    return sum.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CartItemsList(
          items: items,
          removingItemId: removingItemId,
          onRemove: (id) => context.read<CartCubit>().removeFromCart(id),
        ),
        Gap(20.h),
        CartSummary(
          totalPrice: _displayTotal,
          onCheckout: onCheckout,
        ),
        Gap(20.h),
      ],
    );
  }
}
