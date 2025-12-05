import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';

class OrderInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const OrderInfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: AppColors.grey),
        SizedBox(width: 6.w),
        Text(
          text,
          style: TextStyle(fontSize: 13.sp, color: AppColors.grey),
        ),
      ],
    );
  }
}
