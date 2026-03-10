// import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/styles.dart';
import '../../../profile/presentation/widgets/profile_image.dart';
import 'bouncing_text.dart';

class HeaderSection extends StatelessWidget {
  final String? imageUrl;
  final String? userName;
  final VoidCallback? onProfileTap;
  final int favoriteCount;
  final int cartItemCount;
  final VoidCallback? onFavoritesTap;
  final VoidCallback? onCartTap;

  const HeaderSection({
    super.key,
    this.imageUrl,
    this.onProfileTap,
    this.userName,
    this.favoriteCount = 0,
    this.cartItemCount = 0,
    this.onFavoritesTap,
    this.onCartTap,
  });

  Widget _iconWithBadge(
    BuildContext context, {
    required IconData icon,
    required int count,
    required VoidCallback? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: colorScheme.onSurfaceVariant.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22.sp, color: colorScheme.primary),
          ),
          if (count > 0)
            Positioned(
              top: -4.h,
              right: -4.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(60.h),
            BouncingText(
              letters: ['F', 'OO', 'D'],
              colors: [
                colorScheme.primary,
                colorScheme.secondary,
                colorScheme.primary,
              ],
              fontSize: 50,
            ),
            Gap(2.h),
            Text(
              "${'hello'.tr()}, ${userName ?? 'username'.tr()}",
              style: AppTextStyles.titleMedium.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _iconWithBadge(
                context,
                icon: CupertinoIcons.heart_fill,
                count: favoriteCount,
                onTap: onFavoritesTap,
              ),
              Gap(12.w),
              _iconWithBadge(
                context,
                icon: Icons.shopping_cart_outlined,
                count: cartItemCount,
                onTap: onCartTap,
              ),
              Gap(12.w),
              GestureDetector(
                onTap: onProfileTap,
                child: ProfileImage(
                  showUploadButton: false,
                  imageUrl: imageUrl ?? '',
                  width: 60.w,
                  height: 60.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
