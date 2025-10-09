import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/size_config.dart';
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
    final size = SizeConfig(context);

    return Row(
      children: [
        Image.asset(
          AssetsData.customizedBurger,
          height: size.height * 0.31,
        ),
        const Spacer(),
        Column(
          children: [
            const CustomizedText(),
            Gap(size.height * 0.02),
            SpicySlider(
              initialValue: sliderValue,
              onChanged: onSliderChanged,
            ),
          ],
        ),
      ],
    );
  }
}
