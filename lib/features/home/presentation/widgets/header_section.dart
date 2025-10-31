import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../profile/presentation/widgets/profile_image.dart';
import 'bouncing_text.dart';

class HeaderSection extends StatelessWidget {
  final String? imageUrl;
  final String? userName;
  final VoidCallback? onProfileTap;

  const HeaderSection({
    super.key,
    required this.imageUrl,
    this.onProfileTap,
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(60.h),
            BouncingText(
              letters: ['F', 'OO', 'D'],
              colors: [AppColors.primary, AppColors.secondary, AppColors.primary],
              fontSize: 50,
            ),
            Gap(2.h),
            Text(
              "Hello, ${userName ?? 'Username'}",
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: GestureDetector(
            onTap: onProfileTap,
            child: ProfileImage(
              imageUrl: imageUrl ?? '',
              width: 60.w,
              height: 60.h,
            ),
          ),
        ),
      ],
    );
  }
}
