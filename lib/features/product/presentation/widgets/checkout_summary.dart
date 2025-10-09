import 'package:flutter/material.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/styles.dart';

class CheckoutSummary extends StatelessWidget {
  const CheckoutSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 0.05),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$',
                  style: AppTextStyles.displaySmall.copyWith(
                    color: AppColors.primary,
                    fontSize: 40,
                  ),
                ),
                TextSpan(
                  text: '18.19',
                  style: AppTextStyles.displaySmall,
                ),
              ],
            ),
          ),
          const Spacer(),
          CustomButton(
            text: 'Add to Cart',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
