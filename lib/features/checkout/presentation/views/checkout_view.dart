import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/order_checkout_details.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Gap(80.h),
            Text("Order Summary", style: AppTextStyles.bodyBrown),
            Gap(15.h),
            OrderCheckoutDetails(title: "Order", price: "18.8 \$"),
            OrderCheckoutDetails(title: "Taxes", price: "18.8 \$"),
            OrderCheckoutDetails(title: "Delivery fees", price: "18.8 \$"),
            Divider(),
            OrderCheckoutDetails(
              title: "Total:",
              price: "18.8 \$",
              style: AppTextStyles.bodyBrown,),
            OrderCheckoutDetails(
                title: "Estimated delivery time:",
                price: "15 - 30 mins",
            ),
            Gap(60.h),
            Text("Payment Methods", style: AppTextStyles.bodyBrown),
            Gap(20.h),



          ],
        ),
      ),
    );
  }
}

