import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/assets.dart';
import '../widgets/customized_text.dart';
import '../widgets/spicy_slider.dart';

class CustomizedSection extends StatelessWidget {
  final double sliderValue;
  final ValueChanged<double> onSliderChanged;

  const CustomizedSection({
    super.key,
    required this.sliderValue,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(AssetsData.customizedBurger, height: 250.h),
        const Spacer(),
        Column(
          children: [
            const CustomizedText(),
            Gap(15.h),
            SpicySlider(initialValue: sliderValue, onChanged: onSliderChanged),
          ],
        ),
      ],
    );
  }
}
