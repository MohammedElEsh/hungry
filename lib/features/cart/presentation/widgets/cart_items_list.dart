import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/assets.dart';
import '../widgets/cart_item.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = SizeConfig(context);

    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: size.height * 0.1),
        itemCount: 7,
        separatorBuilder: (context, index) => Gap(
            size.height * 0.02),
        itemBuilder: (context, index) {
          return CartItem(
            imagePath: AssetsData.burger,
            title: 'Hamburger Veggie Burger',
            price: '\$18.19',
          );
        },
      ),
    );
  }
}
