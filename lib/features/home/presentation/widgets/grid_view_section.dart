import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/assets.dart';
import '../../../product/data/models/product_model.dart';
import 'card_item.dart';

class GridViewSection extends StatefulWidget {
  final List<ProductModel> products;

  const GridViewSection({super.key, required this.products});

  @override
  State<GridViewSection> createState() => _GridViewSectionState();
}

class _GridViewSectionState extends State<GridViewSection> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        final product = widget.products[index];
        return GestureDetector(
          onTap: () {
            context.push(AppRouter.kProductView, extra: product);
          },
          child: CardItem(
            imagePath: product.image ?? AssetsData.burger,
            title: product.name ?? "Unknown",
            price: "${product.price ?? '0'} \$",
            rating: double.tryParse(product.rating ?? '0') ?? 0.0,
          ),
        );
      }, childCount: widget.products.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 20.h,
        childAspectRatio: 0.7,
      ),
    );
  }
}
