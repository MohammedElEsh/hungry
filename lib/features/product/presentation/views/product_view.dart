import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../cart/data/models/cart_model.dart';
import '../../../cart/data/repositories/cart_repo.dart';
import '../../data/models/product_model.dart';
import '../../data/models/side_options_model.dart';
import '../../data/models/topping_model.dart';
import '../../data/repositories/product_repo.dart';
import '../widgets/checkout_summary.dart';
import '../widgets/product_customization.dart';
import '../widgets/side_options_list.dart';
import '../widgets/toppings_list.dart';

class ProductView extends StatefulWidget {
  final ProductModel? product;

  const ProductView({super.key, this.product});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  double _value = 0.6;
  int _quantity = 1;
  bool _isAddingToCart = false;

  final ProductRepo _repo = ProductRepo();
  final CartRepo _cartRepo = CartRepo();
  List<ToppingModel> toppings = [];
  List<SideOptionsModel> sideOptions = [];
  final Set<int> _selectedToppingIds = {};
  final Set<int> _selectedSideOptionIds = {};

  Future<void> getToppings() async {
    final res = await _repo.getToppings();
    if (!mounted) return;
    setState(() {
      toppings = res;
    });
  }

  Future<void> getSideOptions() async {
    final res = await _repo.getSideOptions();
    if (!mounted) return;
    setState(() {
      sideOptions = res;
    });
  }

  String _getTotalPrice() {
    final unitPrice = double.tryParse(widget.product?.price ?? '0') ?? 0;
    final total = unitPrice * _quantity;
    return total.toStringAsFixed(2);
  }

  Future<void> _addToCart() async {
    final product = widget.product;
    if (product?.id == null) return;

    setState(() => _isAddingToCart = true);
    try {
      final item = CartItem(
        productId: product!.id!,
        quantity: _quantity,
        spicy: _value,
        toppings: _selectedToppingIds.toList(),
        sideOptions: _selectedSideOptionIds.toList(),
      );
      await _cartRepo.addToCart([item]);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Added to cart'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed: $e'), backgroundColor: AppColors.error),
      );
    } finally {
      if (mounted) setState(() => _isAddingToCart = false);
    }
  }

  @override
  void initState() {
    super.initState();
    getToppings();
    getSideOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomizedSection(
                sliderValue: _value,
                onSliderChanged: (value) => setState(() => _value = value),
                quantity: _quantity,
                onIncrement: () => setState(() => _quantity++),
                onDecrement: () {
                  if (_quantity > 1) {
                    setState(() => _quantity--);
                  }
                },
              ),

              Gap(20.h),

              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text("Toppings", style: AppTextStyles.bodyBrown),
              ),
              Gap(15.h),
              ToppingsList(
                toppings: toppings,
                selectedIds: _selectedToppingIds,
                onToppingTapped: (id) {
                  setState(() {
                    if (_selectedToppingIds.contains(id)) {
                      _selectedToppingIds.remove(id);
                    } else {
                      _selectedToppingIds.add(id);
                    }
                  });
                },
              ),
              Gap(30.h),

              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text("Side Options", style: AppTextStyles.bodyBrown),
              ),
              Gap(15.h),
              SideOptionsList(
                items: sideOptions,
                selectedIds: _selectedSideOptionIds,
                onSideOptionTapped: (id) {
                  setState(() {
                    if (_selectedSideOptionIds.contains(id)) {
                      _selectedSideOptionIds.remove(id);
                    } else {
                      _selectedSideOptionIds.add(id);
                    }
                  });
                },
              ),
              Gap(30.h),

              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text("Total", style: AppTextStyles.bodyBrown),
              ),
              CheckoutSummary(
                price: _getTotalPrice(),
                onAddToCart: _addToCart,
                isLoading: _isAddingToCart,
              ),
              // Gap(50.h),
            ],
          ),
        ),
      ),
    );
  }
}
