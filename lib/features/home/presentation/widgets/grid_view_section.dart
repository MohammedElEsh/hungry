import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/assets.dart';
import 'card_item.dart';

class GridViewSection extends StatelessWidget {
  const GridViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) => GestureDetector(
          onTap: () {
            context.push(AppRouter.kProductView);
          },
          child: const CardItem(
            imagePath: AssetsData.burger,
            title: "Cheeseburger",
            price: "12.99 \$",
            rating: 4.7,
          ),
        ),
        childCount: 6,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 20.h,
        childAspectRatio: 0.7,
      ),
    );
  }
}
