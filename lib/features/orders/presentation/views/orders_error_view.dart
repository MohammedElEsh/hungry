import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../actions/orders_actions.dart';

/// Error state view with retry. No business logic; retry via [OrdersActions].
class OrdersErrorView extends StatelessWidget {
  final String message;

  const OrdersErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
              ),
              Gap(16.h),
              TextButton(
                onPressed: () => OrdersActions.load(context),
                child: Text('retry'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
