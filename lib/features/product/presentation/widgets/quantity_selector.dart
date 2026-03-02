import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Quantity", style: AppTextStyles.bodyBrown),
          Gap(15.h),
          Row(
            children: [
              CustomButton(
                onPressed: onDecrement,
                icon: CupertinoIcons.minus,
                width: 45.w,
                height: 40.h,
                borderRadius: 12,
                backgroundColor: AppColors.primary,
                textColor: AppColors.white,
              ),
              Gap(15.w),
              Text(
                '$quantity',
                style: AppTextStyles.titleLarge,
              ),
              Gap(15.w),
              CustomButton(
                onPressed: onIncrement,
                icon: CupertinoIcons.add,
                width: 45.w,
                height: 40.h,
                borderRadius: 12,
                backgroundColor: AppColors.primary,
                textColor: AppColors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}