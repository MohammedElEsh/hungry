import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets.dart';
import '../widgets/topping_card.dart';

class ToppingsList extends StatelessWidget {
  const ToppingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final toppings = [
      {'image': AssetsData.tomatos, 'text': 'Tomato'},
      {'image': AssetsData.onions, 'text': 'Onions'},
      {'image': AssetsData.bacons, 'text': 'Bacons'},
      {'image': AssetsData.pickles, 'text': 'Pickles'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          toppings.length,
              (index) => Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: ToppingCard(
              imagePath: toppings[index]['image']!,
              text: toppings[index]['text']!,
              buttonColor: AppColors.error,
            ),
          ),
        ),
      ),
    );
  }
}
