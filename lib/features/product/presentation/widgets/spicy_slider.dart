import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class SpicySlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double>? onChanged;

  const SpicySlider({
    super.key,
    this.initialValue = 0.5,
    this.onChanged,
  });

  @override
  State<SpicySlider> createState() => _SpicySliderState();
}

class _SpicySliderState extends State<SpicySlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig(context);

    return Column(
      children: [
        Slider(
          value: _value,
          onChanged: (value) {
            setState(() => _value = value);
            if (widget.onChanged != null) widget.onChanged!(value);
          },
          min: 0,
          max: 1,
          activeColor: AppColors.primary,
          // ignore: deprecated_member_use
          inactiveColor: AppColors.grey.withOpacity(0.5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              CupertinoIcons.snow,
              // ignore: deprecated_member_use
              color: _value < 0.5 ? Colors.blue : Colors.blue.withOpacity(0.4),
              size: 28,
            ),
            Gap(sizeConfig.width * 0.22),
            Icon(
              CupertinoIcons.flame,
              // ignore: deprecated_member_use
              color: _value > 0.5 ? Colors.red : Colors.red.withOpacity(0.4),
              size: 28,
            ),
          ],
        ),
      ],
    );
  }
}
