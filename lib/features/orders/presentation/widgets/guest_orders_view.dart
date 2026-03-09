import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/components/feature_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/components/custom_button.dart';

class GuestOrdersView extends StatelessWidget {
  const GuestOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(60.h),

              // Illustration
              Container(
                height: 200.h,
                width: 200.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.receipt_long_rounded,
                  size: 100.sp,
                  color: AppColors.primary,
                ),
              ),
              Gap(30.h),

              // Features List
              FeatureCard(
                icon: Icons.history,
                title: 'order_history'.tr(),
                description: 'guest_orders_desc_1'.tr(),
              ),
              Gap(16.h),
              FeatureCard(
                icon: Icons.notifications_active,
                title: 'realtime_updates'.tr(),
                description: 'guest_orders_desc_2'.tr(),
              ),
              Gap(16.h),
              FeatureCard(
                icon: Icons.replay,
                title: 'reorder_easily'.tr(),
                description: 'guest_orders_desc_3'.tr(),
              ),
              Gap(30.h),

              // Sign Up Button
              CustomButton(
                width: double.infinity,
                backgroundColor: AppColors.secondary,
                text: 'create_account'.tr(),
                icon: Icons.person_add,
                onPressed: () {
                  context.go(AppRouter.kSignupView);
                },
              ),
              // Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }
}
