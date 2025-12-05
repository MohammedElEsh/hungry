import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/components/custom_button.dart';

class EmptyOrdersView extends StatelessWidget {
  final VoidCallback? onHomeTap;

  const EmptyOrdersView({super.key, this.onHomeTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              height: 180.h,
              width: 180.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 90.sp,
                color: AppColors.primary,
              ),
            ),
            Gap(40.h),

            // Title
            Text(
              'No Orders Yet',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            Gap(12.h),

            // Description
            Text(
              'You haven\'t placed any orders yet. Start exploring our delicious menu!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            Gap(40.h),

            // Start Shopping Button
            CustomButton(
              width: 0.7.sw,
              backgroundColor: AppColors.secondary,
              text: 'Start Shopping',
              icon: Icons.restaurant_menu,
              onPressed: onHomeTap,
            ),
          ],
        ),
      ),
    );
  }
}
