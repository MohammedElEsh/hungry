import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/styles.dart';

class OrderCheckoutDetails extends StatelessWidget {
  final String title;
  final String price;
  final TextStyle? style;

  const OrderCheckoutDetails({
    super.key,
    required this.title,
    required this.price,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = style ?? AppTextStyles.bodyGrey;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textStyle),
          Text(price, style: textStyle),
        ],
      ),
    );
  }
}
