import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

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
                TextSpan(text: '18.19', style: AppTextStyles.displaySmall),
              ],
            ),
          ),
          const Spacer(),
          CustomButton(
            text: 'Checkout',
            backgroundColor: AppColors.secondary,
            onPressed: () {
              context.push(AppRouter.kCheckoutView);
            },
          ),
        ],
      ),
    );
  }
}
