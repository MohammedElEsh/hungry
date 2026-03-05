import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/profile_entity.dart';
import '../cubit/profile_cubit.dart';
import '../handlers/profile_controllers.dart';
import '../widgets/add_card_button.dart';
import '../widgets/debit_card.dart';
import '../widgets/profile_actions.dart';
import '../widgets/profile_fields.dart';
import '../widgets/profile_image.dart';

/// Logged-in / update-failed state view. Callbacks from Screen.
class ProfileLoggedInView extends StatelessWidget {
  final ProfileEntity profile;
  final ProfileControllers controllers;
  final File? pickedImage;
  final VoidCallback onUpload;
  final VoidCallback onUpdate;
  final VoidCallback onLogOut;

  const ProfileLoggedInView({
    super.key,
    required this.profile,
    required this.controllers,
    required this.pickedImage,
    required this.onUpload,
    required this.onUpdate,
    required this.onLogOut,
  });

  bool get _hasCard =>
      profile.visa != null && profile.visa!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.white,
      backgroundColor: AppColors.primary,
      onRefresh: () => context.read<ProfileCubit>().loadProfile(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 90.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImage(
              showUploadButton: true,
              imageUrl: profile.image ?? '',
              imageFile: pickedImage,
              onUpload: onUpload,
            ),
            Gap(40.h),
            ProfileFields(
              nameController: controllers.name,
              emailController: controllers.email,
              addressController: controllers.address,
            ),
            // Gap(20.h),
            if (_hasCard)
              DebitCard(profile: profile)
            else
              AddCardButton(
                cardController: controllers.card,
                onPressed: onUpdate,
              ),
            Gap(90.h),
            ProfileActions(
              onEditProfile: onUpdate,
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
