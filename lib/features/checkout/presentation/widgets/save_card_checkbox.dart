import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';

class SaveCardCheckbox extends StatefulWidget {
  const SaveCardCheckbox({super.key});

  @override
  SaveCardCheckboxState createState() => SaveCardCheckboxState();
}

class SaveCardCheckboxState extends State<SaveCardCheckbox> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
          activeColor: AppColors.error,
        ),
        Text(
          "save_card_checkbox".tr(),
          style: AppTextStyles.bodyGrey,
        ),
      ],
    );
  }
}
