import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class PaymentActionSection extends StatelessWidget {
  final String totalPrice;
  final VoidCallback? onPayNow;
  final bool isLoading;

  const PaymentActionSection({
    super.key,
    required this.totalPrice,
    this.onPayNow,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final total = _parseAndComputeTotal(totalPrice);
    return SizedBox(
      height: 120.h,
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$',
                  style: AppTextStyles.displaySmall.copyWith(
                    color: AppColors.primary,
                    fontSize: 40.sp,
                  ),
                ),
                TextSpan(
                  text: _formatPrice(total),
                  style: AppTextStyles.displaySmall,
                ),
              ],
            ),
          ),
          const Spacer(),
          CustomButton(
            backgroundColor: AppColors.secondary,
            text: 'Place Order',
            onPressed: onPayNow ?? () {},
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }

  static double _parseAndComputeTotal(String cartTotalPrice) {
    final orderSubtotal =
        double.tryParse(cartTotalPrice.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
    const taxRate = 0.10;
    const deliveryFee = 2.99;
    return orderSubtotal + (orderSubtotal * taxRate) + deliveryFee;
  }

  static String _formatPrice(double value) {
    return value.toStringAsFixed(2);
  }
}
