import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/custom_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';

class CartSummary extends StatelessWidget {
  final String totalPrice;
  final VoidCallback? onCheckout;

  const CartSummary({
    super.key,
    required this.totalPrice,
    this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                TextSpan(text: totalPrice, style: AppTextStyles.displaySmall),
              ],
            ),
          ),
          const Spacer(),
          CustomButton(
            text: 'checkout'.tr(),
            backgroundColor: AppColors.secondary,
            onPressed: onCheckout,
          ),
        ],
      ),
    );
  }
}
