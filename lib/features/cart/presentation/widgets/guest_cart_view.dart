import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/components/feature_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/components/custom_button.dart';

class GuestCartView extends StatelessWidget {
  final VoidCallback? onHomeTap;

  const GuestCartView({super.key, this.onHomeTap});

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
                  Icons.shopping_cart_outlined,
                  size: 100.sp,
                  color: AppColors.primary,
                ),
              ),
              Gap(30.h),

              // Features List
              FeatureCard(
                icon: Icons.add_shopping_cart,
                title: 'Add to Cart',
                description: 'Save items and checkout when ready',
              ),
              Gap(16.h),
              FeatureCard(
                icon: Icons.check_circle_outline,
                title: 'Secure Checkout',
                description: 'Pay safely with multiple payment options',
              ),
              Gap(16.h),
              FeatureCard(
                icon: Icons.local_shipping_outlined,
                title: 'Fast Delivery',
                description: 'Track your order until it arrives',
              ),
              Gap(30.h),

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
            ],
          ),
        ),
      ),
    );
  }
}
