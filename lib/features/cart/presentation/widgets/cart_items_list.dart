import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/assets.dart';
import '../widgets/cart_item.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 40.h),
        itemCount: 7,
        separatorBuilder: (context, index) => Gap(15.h),
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
