import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_links.dart';
import '../constants/app_colors.dart';
import '../utils/styles.dart';

/// "By signing up you agree to our [Terms] and [Privacy Policy]" in one line
class TermsPrivacyLinks extends StatelessWidget {
  final TextStyle? textStyle;

  const TermsPrivacyLinks({super.key, this.textStyle});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = textStyle ??
        AppTextStyles.bodyMedium.copyWith(
          color: AppColors.grey,
          fontSize: 12.sp, 
        );

    final terms = 'terms_of_service'.tr();
    final privacy = 'privacy_policy'.tr();

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: style,
          children: [
            const TextSpan(text: 'By signing up you agree to our '),
            TextSpan(
              text: terms,
              style: style.copyWith(
                color: AppColors.secondary,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _launch(AppLinks.termsUrl),
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: privacy,
              style: style.copyWith(
                color: AppColors.secondary,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _launch(AppLinks.privacyUrl),
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}

/// Legal links row for Profile/Settings: Terms | Privacy, one line
class LegalLinksRow extends StatelessWidget {
  const LegalLinksRow({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => _launch(AppLinks.termsUrl),
            child: Text(
              'terms_of_service'.tr(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          Text(
            '|',
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 14.sp,
            ),
          ),
          TextButton(
            onPressed: () => _launch(AppLinks.privacyUrl),
            child: Text(
              'privacy_policy'.tr(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.sp), 
            ),
          ),
        ],
      ),
    );
  }
}