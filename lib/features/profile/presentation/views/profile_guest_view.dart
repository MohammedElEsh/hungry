import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/guest_profile_actions.dart';
import '../widgets/guest_profile_fields.dart';
import '../widgets/guest_profile_image.dart';

/// Guest state view. Callbacks from Screen.
class ProfileGuestView extends StatelessWidget {
  final VoidCallback onSignUp;
  final VoidCallback onLogOut;

  const ProfileGuestView({
    super.key,
    required this.onSignUp,
    required this.onLogOut,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.white,
      backgroundColor: AppColors.primary,
      onRefresh: () => context.read<ProfileCubit>().loadProfile(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const GuestProfileImage(),
            Gap(50.h),
            const GuestProfileFields(),
            Gap(60.h),
            GuestProfileActions(
              onSignUp: onSignUp,
              onLogOut: onLogOut,
              isLoggingOut: false,
            ),
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
