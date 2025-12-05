import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/utils/styles.dart';
import '../../../../core/utils/app_colors.dart';

class OrderAmountSection extends StatelessWidget {
  final double totalAmount;
  final VoidCallback? onTap;

  const OrderAmountSection({
    super.key,
    required this.totalAmount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Amount', style: TextStyle(fontSize: 12.sp, color: AppColors.grey)),
            SizedBox(height: 4.h),
            Text(
              '\$${totalAmount.toStringAsFixed(2)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.black
                )
            ),
          ],
        ),
        TextButton.icon(
          onPressed: onTap,
          icon: Icon(Icons.arrow_forward, size: 16.sp, color: AppColors.primary),
          label: Text(
            'View Details',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.black
            )
          ),
        ),
      ],
    );
  }
}
