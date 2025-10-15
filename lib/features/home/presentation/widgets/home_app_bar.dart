import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import 'header_section.dart';
import 'search_bar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

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
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 2.h,
        ),
        child: Column(
          children: [
            const HeaderSection(),
            Gap(25.h),
            const SearchField(),
          ],
        ),
      ),
    );
  }
}
