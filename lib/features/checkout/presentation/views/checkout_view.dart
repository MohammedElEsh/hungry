import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
            OrderSummary(),
            Gap(60.h),
            Text("Payment Methods", style: AppTextStyles.bodyBrown),
            Gap(20.h),
            PaymentMethods(),
            Gap(115.h),
            PaymentActionSection()
          ],
        ),
      ),

    );
  }
}