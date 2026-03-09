import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/custom_list_tile.dart';
import '../widgets/save_card_checkbox.dart';

class PaymentMethods extends StatefulWidget {
  /// Saved card from profile (e.g. masked number)
  final String? savedCardDisplay;

  const PaymentMethods({super.key, this.savedCardDisplay});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  String? selectedMethod = "Cash";

  void onChanged(String? value) {
    setState(() {
      selectedMethod = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cash on delivery option
        CustomListTile(
          title: 'cash_on_delivery'.tr(),
          subtitle: "",
          imageAsset: AssetsData.dollar,
          value: "Cash",
          groupValue: selectedMethod,
          onChanged: onChanged,
          tileColor: AppColors.primary,
          titleStyle: AppTextStyles.titleMedium,
          subtitleStyle: AppTextStyles.bodyGrey,
          imageWidth: 60.w,
          activeColor: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            onChanged("Cash");
          },
        ),
        Gap(20.h),

        // Debit card option (uses saved card from profile when available)
        CustomListTile(
          title: 'debit_card'.tr(),
          subtitle: widget.savedCardDisplay?.isNotEmpty == true
              ? widget.savedCardDisplay!
              : "No card saved",
          imageAsset: AssetsData.visa,
          value: "Debit",
          groupValue: selectedMethod,
          onChanged: onChanged,
          tileColor: AppColors.info.withOpacity(0.1),
          titleStyle: AppTextStyles.titleMedium.copyWith(
            color: AppColors.black,
          ),
          subtitleStyle: AppTextStyles.bodyGrey,
          imageWidth: 60.w,
          activeColor: AppColors.info,
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            onChanged("Debit");
          },
        ),
        // Save card checkbox
        SaveCardCheckbox(),
      ],
    );
  }
}
