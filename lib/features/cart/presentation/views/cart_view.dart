import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../widgets/cart_items_list.dart';
import '../widgets/cart_summary.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CartItemsList(),
          Gap(10.h),
          const CartSummary(),
          Gap(10.h),
        ],
      ),
    );
  }
}
