import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import 'order_status_badge.dart';
import 'order_info_row.dart';
import 'order_amount_section.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final double totalAmount;
  final int itemCount;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.totalAmount,
    required this.itemCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #$orderId',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                OrderStatusBadge(status: status),
              ],
            ),
            Gap(12.h),

            OrderInfoRow(icon: Icons.calendar_today, text: date),
            Gap(8.h),

            OrderInfoRow(
              icon: Icons.shopping_bag_outlined,
              text: '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
            ),
            Gap(12.h),

            Divider(color: AppColors.grey.withOpacity(0.3)),
            Gap(12.h),

            OrderAmountSection(totalAmount: totalAmount, onTap: onTap),
          ],
        ),
      ),
    );
  }
}
