import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../widgets/cart_items_list.dart';
import '../widgets/cart_summary.dart';

/// Cart loading state: Skeletonizer with same layout as loaded (items + summary).
class CartLoadingView extends StatelessWidget {
  const CartLoadingView({super.key});

  static final List<CartItemEntity> _skeletonItems = [
    const CartItemEntity(
      id: '0',
      productId: '0',
      name: 'Loading item name',
      price: 0,
      quantity: 1,
    ),
    const CartItemEntity(
      id: '1',
      productId: '1',
      name: 'Loading item name',
      price: 0,
      quantity: 1,
    ),
    const CartItemEntity(
      id: '2',
      productId: '2',
      name: 'Loading item name',
      price: 0,
      quantity: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: Colors.grey.shade300.withOpacity(0.3),
        highlightColor: Colors.grey.shade100.withOpacity(0.1),
        duration: const Duration(milliseconds: 1200),
      ),
      child: Column(
        children: [
          CartItemsList(
            items: _skeletonItems,
            onRemove: (_) {},
          ),
          Gap(20.h),
          CartSummary(totalPrice: '0.00'),
          Gap(20.h),
        ],
      ),
    );
  }
}
