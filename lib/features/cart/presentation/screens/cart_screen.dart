import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import '../cubit/cart_cubit.dart';
import '../listeners/cart_listener.dart';
import '../views/cart_view_factory.dart';

/// Cart screen: Scaffold + BlocConsumer, delegates to CartViewFactory.
class CartScreen extends StatelessWidget {
  final VoidCallback? onHomeTap;

  const CartScreen({super.key, this.onHomeTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) => handleCartState(context, state),
        builder: (context, state) {
          return CartViewFactory.build(
            context,
            state,
            onContinueShopping: onHomeTap ?? () => context.go(AppRouter.kHomeView),
            onCheckout: () => context.push(AppRouter.kCheckoutView),
          );
        },
      ),
    );
  }
}
