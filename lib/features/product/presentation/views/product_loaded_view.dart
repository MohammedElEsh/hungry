import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/styles.dart';
import '../actions/product_actions.dart';
import '../cubit/product_cubit.dart';
import '../widgets/checkout_summary.dart';
import '../widgets/product_customization.dart';
import '../widgets/side_options_list.dart';
import '../widgets/toppings_list.dart';

/// Loaded state: customization, toppings, side options, checkout. Actions via [ProductActions].
class ProductLoadedView extends StatelessWidget {
  final ProductLoaded state;

  const ProductLoadedView({super.key, required this.state});

  static String _formatPrice(double value) => value.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    final product = state.product;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomizedSection(
                sliderValue: state.spicyLevel,
                onSliderChanged: (v) => ProductActions.setSpicyLevel(context, v),
                quantity: state.quantity,
                onIncrement: () =>
                    ProductActions.setQuantity(context, state.quantity + 1),
                onDecrement: () {
                  if (state.quantity > 1) {
                    ProductActions.setQuantity(context, state.quantity - 1);
                  }
                },
              ),
              Gap(20.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text('Toppings', style: AppTextStyles.bodyBrown),
              ),
              Gap(15.h),
              ToppingsList(
                toppings: product.toppings,
                selectedIds: state.selectedToppingIds,
                onToppingTapped: (id) => ProductActions.toggleTopping(context, id),
              ),
              Gap(20.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text('Side Options', style: AppTextStyles.bodyBrown),
              ),
              Gap(15.h),
              SideOptionsList(
                items: product.sideOptions,
                selectedIds: state.selectedSideOptionIds,
                onSideOptionTapped: (id) =>
                    ProductActions.toggleSideOption(context, id),
              ),
              Gap(30.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text('Total', style: AppTextStyles.bodyBrown),
              ),
              CheckoutSummary(
                price: _formatPrice(product.price * state.quantity),
                onAddToCart: () => ProductActions.addToCart(context),
                isLoading: state.isAddingToCart,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
