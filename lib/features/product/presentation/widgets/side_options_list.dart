import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets.dart';
import '../widgets/topping_card.dart';

class SideOptionsList extends StatelessWidget {
  const SideOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final toppings = [
      {'image': AssetsData.fries, 'text': 'Fries'},
      {'image': AssetsData.coleslaw, 'text': 'Coleslaw'},
      {'image': AssetsData.salad, 'text': 'Salad'},
      {'image': AssetsData.onionrings, 'text': 'Onion Rings'},
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
              buttonColor: AppColors.success,
            ),
          ),
        ),
      ),
    );
  }
}
