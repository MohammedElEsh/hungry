// home_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import 'header_section.dart';
import 'search_bar.dart';

class HomeAppBar extends StatelessWidget {
  final String? imageUrl;
  final String? userName;
  final VoidCallback? onProfileTap;
  final int favoriteCount;
  final int cartItemCount;
  final VoidCallback? onFavoritesTap;
  final VoidCallback? onCartTap;

  const HomeAppBar({
    super.key,
    this.onProfileTap,
    this.imageUrl,
    this.userName,
    this.favoriteCount = 0,
    this.cartItemCount = 0,
    this.onFavoritesTap,
    this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      pinned: true,
      toolbarHeight: 220.h,
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
        child: Column(
          children: [
            HeaderSection(
              imageUrl: imageUrl,
              userName: userName,
              onProfileTap: onProfileTap,
              favoriteCount: favoriteCount,
              cartItemCount: cartItemCount,
              onFavoritesTap: onFavoritesTap,
              onCartTap: onCartTap,
            ),
            Gap(25.h),
            const SearchField(),
          ],
        ),
      ),
    );
  }
}
