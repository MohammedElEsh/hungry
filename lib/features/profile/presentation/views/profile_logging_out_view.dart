import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Logging-out state view. Declarative only.
class ProfileLoggingOutView extends StatelessWidget {
  const ProfileLoggingOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: Colors.grey.shade300.withOpacity(0.3),
        highlightColor: Colors.grey.shade100.withOpacity(0.1),
        duration: const Duration(milliseconds: 1200),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, size: 48.sp, color: Colors.grey),
            Gap(16.h),
            Text('Logging out...', style: TextStyle(fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }
}
