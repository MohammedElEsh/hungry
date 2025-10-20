import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/order_checkout_details.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(15.h),
        OrderCheckoutDetails(title: "Order", price: "18.8 \$"),
        OrderCheckoutDetails(title: "Taxes", price: "18.8 \$"),
        OrderCheckoutDetails(title: "Delivery fees", price: "18.8 \$"),
        Divider(),
        OrderCheckoutDetails(
          title: "Total:",
          price: "92.41 \$",
          style: AppTextStyles.bodyBrown,
        ),
        OrderCheckoutDetails(
          title: "Estimated delivery time:",
          price: "15 - 30 mins",
        ),
      ],
    );
  }
}
