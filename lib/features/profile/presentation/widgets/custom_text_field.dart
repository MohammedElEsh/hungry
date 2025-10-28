import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.white,
      cursorHeight: 20.h,
      style: TextStyle(color: AppColors.white),
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
