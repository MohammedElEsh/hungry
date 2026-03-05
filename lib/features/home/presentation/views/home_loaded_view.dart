import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/animations/fade_in.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../product/data/models/product_model.dart';
import '../../domain/entities/product_entity.dart';
import '../actions/home_actions.dart';
import '../cubit/home_cubit.dart';
import '../widgets/categories_list.dart';
import '../widgets/grid_view_section.dart';
import '../widgets/home_app_bar.dart';

/// Loaded state: categories, product grid, cart-aware app bar. Actions via [HomeActions].
class HomeLoadedView extends StatelessWidget {
  final HomeLoaded state;
  final VoidCallback? onProfileTap;
  final VoidCallback? onCartTap;

  const HomeLoadedView({
    super.key,
    required this.state,
    this.onProfileTap,
    this.onCartTap,
  });

  static ProductModel _entityToModel(ProductEntity e) => ProductModel(
        id: int.tryParse(e.id),
        name: e.name,
        price: e.price.toString(),
        image: e.imageUrl,
        rating: e.rating,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (prev, next) =>
          next is CartLoaded || next is CartInitial || next is CartError,
      builder: (context, cartState) {
        final cartCount =
            cartState is CartLoaded ? cartState.items.length : 0;
        final userName = state.user?.name?.trim().isNotEmpty == true
            ? state.user!.name
            : state.user?.email;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              HomeAppBar(
                imageUrl: state.user?.image?.trim().isNotEmpty == true
                    ? state.user!.image
                    : null,
                userName: userName,
                onProfileTap: onProfileTap,
                favoriteCount: state.favoriteIds.length,
                cartItemCount: cartCount,
                onCartTap: onCartTap,
                onFavoritesTap: null,
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoriesList(
                      categories: [
                        'All',
                        ...state.categories.map((c) => c.name),
                      ],
                      currentIndex: state.selectedCategoryIndex,
                      onCategoryTap: (i) =>
                          HomeActions.selectCategory(context, i),
                    ),
                    Gap(25.h),
                  ],
                ),
              ),
              if (state.products.isEmpty)
                SliverFillRemaining(
                  child: FadeIn(
                    child: EmptyStateWidget(
                      title: 'No products',
                      subtitle: 'Check back later',
                      icon: Icons.restaurant_menu,
                    ),
                  ),
                )
              else
                GridViewSection(
                  products: state.products.map(_entityToModel).toList(),
                  favoriteIds: state.favoriteIds,
                  onFavoriteTap: (id) =>
                      HomeActions.toggleFavorite(context, id),
                ),
            ],
          ),
        );
      },
    );
  }
}
