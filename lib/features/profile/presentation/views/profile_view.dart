import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/utils/app_colors.dart';
import 'package:hungry/features/profile/presentation/widgets/profile_bottom_sheet.dart';
import 'package:hungry/features/profile/presentation/widgets/profile_fields.dart';
import 'package:hungry/features/profile/presentation/widgets/profile_image.dart';
import '../widgets/debit_card.dart';

class ProfileView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: EdgeInsets.only(top: 80.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImage(),

            Gap(50.h),

            ProfileFields(
              nameController: nameController,
              emailController: emailController,
              addressController: addressController,
              passwordController: passwordController,
            ),

            DebitCard(),
          ],
        ),
      ),
      bottomSheet: ProfileBottomSheet(),
    );
  }
}
