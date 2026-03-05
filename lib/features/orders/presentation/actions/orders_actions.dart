import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/alerts.dart';
import '../../domain/entities/order_entity.dart';
import '../cubit/orders_cubit.dart';

/// Entry points for orders side-effects. Keeps UI declarative; logic in Cubit.
abstract final class OrdersActions {
  static void load(BuildContext context) {
    context.read<OrdersCubit>().loadOrders();
  }

  static Future<void> refresh(BuildContext context) async {
    await context.read<OrdersCubit>().refresh();
  }

  static void showOrderDetails(BuildContext context, OrderEntity order) {
    showInfoBanner(context, 'Order #${order.id} details');
  }
}
