import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileActions extends StatelessWidget {
  final VoidCallback? onEditProfile;
  final VoidCallback? onLogOut;
  final VoidCallback? onChangePassword;
  final VoidCallback? onDeleteAccount;
  final bool isLoggingOut;

  const ProfileActions({
    super.key,
    this.onEditProfile,
    this.onLogOut,
    this.onChangePassword,
    this.onDeleteAccount,
    this.isLoggingOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (onChangePassword != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: TextButton.icon(
                    onPressed: onChangePassword,
                    icon: Icon(
                      CupertinoIcons.lock,
                      size: 18.sp,
                      color: AppColors.primary,
                    ),
                    label: Text(
                      'change_password'.tr(),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              if (onDeleteAccount != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: TextButton.icon(
                    onPressed: onDeleteAccount,
                    icon: Icon(
                      CupertinoIcons.trash,
                      size: 18.sp,
                      color: AppColors.error,
                    ),
                    label: Text(
                      'delete_account'.tr(),
                      style: TextStyle(color: AppColors.error, fontSize: 14.sp),
                    ),
                  ),
                ),
            ],
          ),
          Gap(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                backgroundColor: AppColors.secondary,
                text: 'edit_profile'.tr(),
                icon: CupertinoIcons.pen,
                onPressed: onEditProfile,
              ),
              isLoggingOut
                  ? SizedBox(
                      width: 170.w,
                      height: 60.h,
                      child: Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : CustomButton(
                      backgroundColor: AppColors.white,
                      text: 'log_out'.tr(),
                      textColor: AppColors.primary,
                      border: Border.all(color: AppColors.primary),
                      icon: CupertinoIcons.square_arrow_right_fill,
                      onPressed: onLogOut,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
