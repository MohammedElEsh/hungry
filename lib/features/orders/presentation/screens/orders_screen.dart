import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../actions/orders_actions.dart';
import '../cubit/orders_cubit.dart';
import '../listener/orders_listener.dart';
import '../views/orders_view_factory.dart';

/// Orders feature screen: Scaffold + BlocConsumer. No business logic; layout and state → view only.
/// - Listener: side-effects (e.g. error snackbar).
/// - Builder: view from [OrdersViewFactory] for current [OrdersState].
class OrdersScreen extends StatefulWidget {
  final VoidCallback onHomeTap;

  const OrdersScreen({super.key, required this.onHomeTap});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) OrdersActions.load(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: OrdersListener.listen,
        builder: (context, state) {
          return OrdersViewFactory.build(
            context,
            state,
            onHomeTap: widget.onHomeTap,
          );
        },
      ),
    );
  }
}
