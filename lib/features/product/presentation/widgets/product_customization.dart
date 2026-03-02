import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/assets.dart';
import '../widgets/customized_text.dart';
import '../widgets/spicy_slider.dart';
import '../widgets/quantity_selector.dart';

class CustomizedSection extends StatelessWidget {
  final double sliderValue;
  final ValueChanged<double> onSliderChanged;

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CustomizedSection({
    super.key,
    required this.sliderValue,
    required this.onSliderChanged,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AssetsData.customizedBurger,
          height: 250.h,
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomizedText(),
            Gap(15.h),

            /// 🔥 Spicy Slider
            SpicySlider(
              initialValue: sliderValue,
              onChanged: onSliderChanged,
            ),

            Gap(20.h),

            /// ➕➖ Quantity
            QuantitySelector(
              quantity: quantity,
              onIncrement: onIncrement,
              onDecrement: onDecrement,
            ),
          ],
        ),
      ],
    );
  }
}