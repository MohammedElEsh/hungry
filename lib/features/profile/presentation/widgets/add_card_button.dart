import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import 'custom_text_field.dart';

class AddCardButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final TextEditingController cardController;

  const AddCardButton({
    super.key,
    this.onPressed,
    required this.cardController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextField(
            controller: cardController,
            labelText: 'Card Number',
            keyboardType: TextInputType.number,
          ),
          Gap(10.h),
          CustomButton(
            text: 'Add New Card',
            icon: CupertinoIcons.add,
            width: double.infinity,
            height: 60.h,
            borderRadius: 12.r,
            textColor: AppColors.white,
            backgroundColor: AppColors.primary,
            border: Border.all(color: AppColors.fifth),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
