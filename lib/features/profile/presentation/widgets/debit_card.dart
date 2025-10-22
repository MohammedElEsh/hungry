import 'package:flutter/material.dart';
import 'package:hungry/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/assets.dart';
import '../../../checkout/presentation/widgets/custom_list_tile.dart';

class DebitCard extends StatelessWidget {
  const DebitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: CustomListTile(
        title: "Debit Card",
        subtitle: "**** **** **** 9142",
        imageAsset: AssetsData.visa,
        value: "Debit",
        groupValue: "Debit",
        onChanged: (value) {},
        tileColor: AppColors.white,
        titleStyle: TextStyle(color: AppColors.black),
        subtitleStyle: TextStyle(color: AppColors.grey),
        imageWidth: 60.w,
        activeColor: AppColors.info,
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}
