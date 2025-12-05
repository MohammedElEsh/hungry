import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';

class ProfileActions extends StatelessWidget {
  final VoidCallback? onEditProfile;
  final VoidCallback? onLogOut;
  final bool isLoggingOut;

  const ProfileActions({
    super.key,
    this.onEditProfile,
    this.onLogOut,
    this.isLoggingOut = false,
  });

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
          isLoggingOut
              ? SizedBox(
                  width: 170.w,
                  height: 60.h,
                  child: Center(
                    child: CupertinoActivityIndicator(color: AppColors.primary),
                  ),
                )
              : CustomButton(
                  backgroundColor: AppColors.white,
                  text: 'Log out',
                  textColor: AppColors.primary,
                  border: Border.all(color: AppColors.primary),
                  icon: CupertinoIcons.square_arrow_right_fill,
                  onPressed: onLogOut,
                ),
        ],
      ),
    );
  }
}
