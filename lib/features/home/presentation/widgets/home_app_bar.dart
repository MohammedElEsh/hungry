import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/app_colors.dart';
import 'header_section.dart';
import 'search_bar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig(context);

    return SliverAppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      pinned: true,
      toolbarHeight: sizeConfig.height * 0.27,
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sizeConfig.width * 0.03,
          vertical: sizeConfig.height * 0.001,
        ),
        child: Column(
          children: [
            const HeaderSection(),
            Gap(sizeConfig.height * 0.02),
            const SearchField(),
          ],
        ),
      ),
    );
  }
}
