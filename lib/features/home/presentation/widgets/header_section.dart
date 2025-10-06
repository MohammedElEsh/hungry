import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/styles.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(sizeConfig.height * 0.1),
            Text(
              "HUNGRY?",
              style: AppTextStyles.displayLarge.copyWith(
                color: AppColors.primary,
                fontSize: 50,
              ),
            ),
            Gap(sizeConfig.height * 0.0001),
            Text(
              "Hello, Username",
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(top: sizeConfig.height * 0.1),
          child: CircleAvatar(
            radius: sizeConfig.height * 0.04,
            backgroundColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
