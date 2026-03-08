import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/animations/fade_in.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/empty_state_widget.dart';

/// Shown for [HomeInitial] or unknown state (e.g. while transitioning).
class HomeInitialView extends StatelessWidget {
  const HomeInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: FadeIn(
        child: EmptyStateWidget(
          title: 'loading'.tr(),
          icon: Icons.hourglass_empty,
        ),
      ),
    );
  }
}
