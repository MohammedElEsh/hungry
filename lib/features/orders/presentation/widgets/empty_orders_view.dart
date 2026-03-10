import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/components/custom_button.dart';

class EmptyOrdersView extends StatelessWidget {
  final VoidCallback? onHomeTap;

  const EmptyOrdersView({super.key, this.onHomeTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
                color: colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 90.sp,
                color: colorScheme.primary,
              ),
            ),
            Gap(40.h),

            // Title
            Text(
              'no_orders_yet'.tr(),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            Gap(12.h),

            // Description
            Text(
              'no_orders_description'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            Gap(40.h),

            // Start Shopping Button
            CustomButton(
              width: 0.7.sw,
              backgroundColor: AppColors.secondary,
              text: 'start_shopping'.tr(),
              icon: Icons.restaurant_menu,
              onPressed: onHomeTap,
            ),
          ],
        ),
      ),
    );
  }
}
