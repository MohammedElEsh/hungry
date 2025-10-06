import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(12),
      child: TextField(
        style: AppTextStyles.titleMedium.copyWith(
          color: AppColors.grey,
        ),
        decoration: InputDecoration(
          hintText: 'Search for restaurants...',
          hintStyle: AppTextStyles.titleMedium.copyWith(
            color: AppColors.grey,
          ),
          fillColor: AppColors.white,
          filled: true,
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: AppColors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
