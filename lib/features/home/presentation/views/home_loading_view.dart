import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/skeleton_loading.dart';
import '../../../product/data/models/product_model.dart';
import '../widgets/categories_list.dart';
import '../widgets/grid_view_section.dart';
import '../widgets/home_app_bar.dart';

/// Skeleton view shown when home data is loading.
class HomeLoadingView extends StatelessWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onCartTap;

  const HomeLoadingView({
    super.key,
    this.onProfileTap,
    this.onCartTap,
  });

  static List<ProductModel> get _skeletonProducts => List.generate(
        6,
        (i) => ProductModel(
          id: i,
          name: 'loading'.tr(),
          price: '0',
          image: null,
          rating: null,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: skeletonize(
          enabled: true,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              HomeAppBar(
                imageUrl: null,
                userName: 'loading'.tr(),
                onProfileTap: onProfileTap,
                favoriteCount: 0,
                cartItemCount: 0,
                onCartTap: onCartTap,
                onFavoritesTap: null,
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoriesList(
                      categories: ['all'.tr(), 'loading'.tr(), 'loading'.tr(), 'loading'.tr()],
                      currentIndex: 0,
                      onCategoryTap: (_) {},
                    ),
                    Gap(25.h),
                  ],
                ),
              ),
              GridViewSection(
                products: _skeletonProducts,
                favoriteIds: const {},
                onFavoriteTap: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
