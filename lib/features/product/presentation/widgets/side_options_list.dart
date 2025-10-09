import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/assets.dart';
import '../widgets/topping_card.dart';

class SideOptionsList extends StatelessWidget {
  const SideOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = SizeConfig(context);

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
            padding: EdgeInsets.only(left: size.width * 0.04),
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
