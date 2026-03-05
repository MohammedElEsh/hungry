import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/components/profile_text_field.dart';

class ProfileFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  // final TextEditingController passwordController;

  const ProfileFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.addressController,
    // required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          // Name TextField
          ProfileTextField(
            controller: nameController,
            labelText: 'Name',
            // readOnly: true,
          ),
          Gap(20.h),
          // Email TextField
          ProfileTextField(
            controller: emailController,
            labelText: 'Email',
            readOnly: true,
          ),
          Gap(20.h),
          // Address TextField
          ProfileTextField(
            controller: addressController,
            labelText: 'Address',
            // readOnly: true,
          ),
          Gap(20.h),
          // Password TextField
          // CustomTextField(
          //   controller: passwordController,
          //   labelText: 'Password',
          //   obscureText: true,
          //   readOnly: true,
          // ),
          // Gap(20.h),
          Divider(),
          Gap(20.h),
        ],
      ),
    );
  }
}
