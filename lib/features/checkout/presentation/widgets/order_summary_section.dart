import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/styles.dart';
import '../../../cart/data/models/cart_model.dart';
import '../widgets/order_checkout_details.dart';

class OrderSummary extends StatelessWidget {
  final CartModel cart;

  const OrderSummary({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    final orderSubtotal = _parsePrice(cart.totalPrice);
    const taxRate = 0.10; // 10% tax
    const deliveryFee = 2.99;
    final taxes = orderSubtotal * taxRate;
    final total = orderSubtotal + taxes + deliveryFee;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(15.h),
        OrderCheckoutDetails(
          title: "Order",
          price: "\$ ${_formatPrice(orderSubtotal)}",
        ),
        OrderCheckoutDetails(
          title: "Taxes",
          price: "\$ ${_formatPrice(taxes)}",
        ),
        OrderCheckoutDetails(
          title: "Delivery fees",
          price: "\$ ${_formatPrice(deliveryFee)}",
        ),
        Divider(),
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

  static double _parsePrice(String value) {
    return double.tryParse(value.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
  }

  static String _formatPrice(double value) {
    return value.toStringAsFixed(2);
  }
}
