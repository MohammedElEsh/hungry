import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../actions/product_actions.dart';
import '../cubit/product_cubit.dart';
import '../listener/product_listener.dart';
import '../views/product_view_factory.dart';

/// Product detail screen: BlocConsumer + ViewFactory. No business logic; listeners for side-effects.
class ProductScreen extends StatefulWidget {
  final String? productId;

  const ProductScreen({super.key, this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    final id = widget.productId;
    if (id != null && id.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) ProductActions.load(context, id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: ProductListener.listenCart,
      listenWhen: (_, next) => next is CartError,
      child: BlocConsumer<ProductCubit, ProductState>(
        listenWhen: (prev, next) =>
            next is ProductLoaded &&
            (next.addToCartSuccess == true || next.addToCartError != null),
        listener: ProductListener.listenProduct,
        builder: (context, state) {
          return ProductViewFactory.build(
            context,
            state,
            productId: widget.productId,
          );
        },
      ),
    );
  }
}
