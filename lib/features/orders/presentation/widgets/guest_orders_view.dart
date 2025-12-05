import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/components/feature_card.dart';
import '../../../../core/utils/app_colors.dart';
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
              Gap(40.h),

              // Features List
              FeatureCard(
                icon: Icons.history,
                title: 'Order History',
                description: 'Track all your past and current orders',
              ),
              Gap(16.h),
              FeatureCard(
                icon: Icons.notifications_active,
                title: 'Real-time Updates',
                description: 'Get notified about your order status',
              ),
              Gap(16.h),
              FeatureCard(
                icon: Icons.replay,
                title: 'Reorder Easily',
                description: 'Quickly reorder your favorite meals',
              ),
              Gap(50.h),

              // Sign Up Button
              CustomButton(
                width: double.infinity,
                backgroundColor: AppColors.secondary,
                text: 'Create Account',
                icon: Icons.person_add,
                onPressed: () {
                  context.go(AppRouter.kSignupView);
                },
              ),
              Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }
}
