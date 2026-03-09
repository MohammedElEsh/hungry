import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/theme_notifier.dart';

/// Theme mode selector (Light / Dark / System).
class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = sl<ThemeNotifier>();
    return ListenableBuilder(
      listenable: themeNotifier,
      builder: (context, _) {
        final mode = themeNotifier.themeMode;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'theme'.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(8.h),
              Row(
                children: [
                  _ThemeChip(
                    label: 'theme_light'.tr(),
                    isSelected: mode == ThemeMode.light,
                    onTap: () => themeNotifier.setThemeMode(ThemeMode.light),
                  ),
                  Gap(8.w),
                  _ThemeChip(
                    label: 'theme_dark'.tr(),
                    isSelected: mode == ThemeMode.dark,
                    onTap: () => themeNotifier.setThemeMode(ThemeMode.dark),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ThemeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
