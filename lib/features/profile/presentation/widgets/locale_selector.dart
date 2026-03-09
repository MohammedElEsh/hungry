import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/locale_notifier.dart';

/// Language/locale selector (English / العربية).
class LocaleSelector extends StatelessWidget {
  const LocaleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final localeNotifier = sl<LocaleNotifier>();
    return ListenableBuilder(
      listenable: localeNotifier,
      builder: (context, _) {
        final currentLocale = localeNotifier.locale.languageCode;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'language'.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(8.h),
              Row(
                children: [
                  _LocaleChip(
                    label: 'language_english'.tr(),
                    isSelected: currentLocale == 'en',
                    onTap: () async {
                      await localeNotifier.setLocale(const Locale('en'));
                      // ignore: use_build_context_synchronously
                      await context.setLocale(const Locale('en'));
                    },
                  ),
                  Gap(8.w),
                  _LocaleChip(
                    label: 'language_arabic'.tr(),
                    isSelected: currentLocale == 'ar',
                    onTap: () async {
                      await localeNotifier.setLocale(const Locale('ar'));
                      // ignore: use_build_context_synchronously
                      await context.setLocale(const Locale('ar'));
                    },
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

class _LocaleChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LocaleChip({
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
            color: isSelected
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant.withOpacity(0.3),
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
