import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/utils/app_router.dart';

class ProfileActions extends StatelessWidget {
  final VoidCallback? onEditProfile;
  const ProfileActions({super.key, this.onEditProfile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            backgroundColor: AppColors.secondary,
            text: 'Edit Profile',
            icon: CupertinoIcons.pen,
            onPressed: onEditProfile,
          ),
          CustomButton(
            backgroundColor: AppColors.white,
            text: 'Log out',
            textColor: AppColors.primary,
            border: Border.all(color: AppColors.primary),
            icon: CupertinoIcons.square_arrow_right_fill,
            onPressed: () {
              context.go(AppRouter.kLoginView);
            },
          ),
        ],
      ),
    );
  }
}
