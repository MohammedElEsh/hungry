import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/styles.dart';
import 'order_checkout_details.dart';

class OrderSummarySection extends StatelessWidget {
  final double subtotal;

  const OrderSummarySection({super.key, required this.subtotal});

  @override
  Widget build(BuildContext context) {
    const taxRate = 0.10;
    const deliveryFee = 2.99;
    final taxes = subtotal * taxRate;
    final total = subtotal + taxes + deliveryFee;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(15.h),
        OrderCheckoutDetails(
          title: "Order",
          price: "\$ ${_formatPrice(subtotal)}",
        ),
        OrderCheckoutDetails(
          title: "Taxes",
          price: "\$ ${_formatPrice(taxes)}",
        ),
        OrderCheckoutDetails(
          title: "Delivery fees",
          price: "\$ ${_formatPrice(deliveryFee)}",
        ),
        const Divider(),
        OrderCheckoutDetails(
          title: "Total:",
          price: "\$ ${_formatPrice(total)}",
          style: AppTextStyles.bodyBrown,
        ),
        OrderCheckoutDetails(
          title: "Estimated delivery time:",
          price: "15 - 30 mins",
        ),
      ],
    );
  }

  static String _formatPrice(double value) => value.toStringAsFixed(2);
}
