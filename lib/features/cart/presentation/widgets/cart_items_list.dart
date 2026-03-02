import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../data/models/cart_model.dart';
import 'cart_item.dart';

class CartItemsList extends StatelessWidget {
  final List<CartDisplayItem> items;
  final ValueChanged<int> onRemove;

  const CartItemsList({super.key, required this.items, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 18.sp, color: Colors.grey),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 40.h),
        itemCount: items.length,
        separatorBuilder: (context, index) => Gap(15.h),
        itemBuilder: (context, index) {
          final item = items[index];
          return CartItemWidget(
            item: item,
            onRemove: () => onRemove(item.itemId),
          );
        },
      ),
    );
  }
}
