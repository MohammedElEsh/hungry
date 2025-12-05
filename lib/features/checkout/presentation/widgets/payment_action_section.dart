import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class PaymentActionSection extends StatelessWidget {
  const PaymentActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      // decoration: BoxDecoration(
      //   color: AppColors.white,
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(20.r),
      //   ),
      // ),
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
                TextSpan(text: '92.41', style: AppTextStyles.displaySmall),
              ],
            ),
          ),
          const Spacer(),
          CustomButton(text: 'Pay Now', onPressed: () {}),
        ],
      ),
    );
  }
}
