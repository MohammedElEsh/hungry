import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/styles.dart';
import '../../../checkout/presentation/widgets/custom_list_tile.dart';
import '../../domain/entities/profile_entity.dart';

class DebitCard extends StatelessWidget {
  final ProfileEntity? profile;

  const DebitCard({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: CustomListTile(
        title: 'debit_card'.tr(),
        subtitle: (profile?.visa != null && profile!.visa!.isNotEmpty)
            ? profile!.visa!
            : "**** **** **** 9142",
        imageAsset: AssetsData.visa,
        value: "Debit",
        groupValue: "Debit",
        onChanged: (value) {},
        tileColor: AppColors.info.withOpacity(0.15),
        titleStyle: AppTextStyles.titleMedium.copyWith(color: AppColors.black),
        subtitleStyle: AppTextStyles.bodyGrey,
        imageWidth: 60.w,
        activeColor: AppColors.info,
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}
