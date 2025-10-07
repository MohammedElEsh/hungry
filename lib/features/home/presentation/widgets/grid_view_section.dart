import 'package:flutter/material.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/size_config.dart';
import 'card_item.dart';

class GridViewSection extends StatelessWidget {
  const GridViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig(context);

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) => const CardItem(
          imagePath: AssetsData.burger,
          title: "Cheeseburger",
          price: "12.99 \$",
          rating: 4.7,
        ),
        childCount: 6,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: sizeConfig.width * 0.04,
        mainAxisSpacing: sizeConfig.height * 0.03,
        childAspectRatio: 0.7,
      ),
    );
  }
}
