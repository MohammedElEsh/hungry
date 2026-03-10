import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/order_entity.dart';
import '../actions/orders_actions.dart';
import '../widgets/order_card.dart';

/// Loaded state: list of orders with pull-to-refresh. Tap handled by [OrdersActions].
class OrdersLoadedView extends StatelessWidget {
  final List<OrderEntity> orders;

  const OrdersLoadedView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: RefreshIndicator(
        color: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
        onRefresh: () => OrdersActions.refresh(context),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 45.w),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return OrderCard(
              order: order,
              onTap: () => OrdersActions.showOrderDetails(context, order),
            );
          },
        ),
      ),
    );
  }
}
