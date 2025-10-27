import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/utils/app_router.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              text: 'Edit Profile',
              icon: CupertinoIcons.pen,
              onPressed: () {},
            ),
            CustomButton(
              backgroundColor: AppColors.third,
              text: 'Log out',
              icon: CupertinoIcons.square_arrow_right_fill,
              onPressed: () {
                context.go(AppRouter.kLoginView);
              },
            ),
          ],
        ),
      ),
    );
  }
}
