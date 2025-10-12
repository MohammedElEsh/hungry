import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/size_config.dart';
import '../widgets/cart_items_list.dart';
import '../widgets/cart_summary.dart';



class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = SizeConfig(context);

    return Scaffold(
      body: Column(

        children: [
          CartItemsList(),
          Gap(size.height * 0.01),
          CartSummary(),
          Gap(size.height * 0.01),

        ],
      ),
    );
  }
}

