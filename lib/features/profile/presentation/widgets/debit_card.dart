import 'package:flutter/material.dart';
import 'package:hungry/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/styles.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../checkout/presentation/widgets/custom_list_tile.dart';

class DebitCard extends StatelessWidget {
  final UserModel? userModel;
  const DebitCard({super.key, this.userModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: CustomListTile(
        title: "Debit Card",
        subtitle: userModel?.visa.toString() ?? "**** **** **** 9142",
        imageAsset: AssetsData.visa,
        value: "Debit",
        groupValue: "Debit",
        onChanged: (value) {},
        tileColor: AppColors.info.withOpacity(0.15),
        titleStyle: AppTextStyles.titleMedium.copyWith(
          color: AppColors.black,
        ),
        subtitleStyle: AppTextStyles.bodyGrey,
        imageWidth: 60.w,
        activeColor: AppColors.info,
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}
