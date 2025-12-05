import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../auth/data/repositories/auth_repo.dart';
import '../widgets/guest_orders_view.dart';
import '../widgets/empty_orders_view.dart';
import '../widgets/order_card.dart';

class OrdersView extends StatefulWidget {
  final VoidCallback onHomeTap;

  const OrdersView({super.key, required this.onHomeTap});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final AuthRepo authRepo = AuthRepo();
  bool isLoading = false;

  // Mock orders data - Replace with actual API call
  List<Map<String, dynamic>> orders = [
    {
      'orderId': '12345',
      'date': 'Dec 4, 2025',
      'status': 'Delivered',
      'totalAmount': 45.99,
      'itemCount': 3,
    },
    {
      'orderId': '12344',
      'date': 'Dec 3, 2025',
      'status': 'Processing',
      'totalAmount': 32.50,
      'itemCount': 2,
    },
    {
      'orderId': '12343',
      'date': 'Dec 1, 2025',
      'status': 'Pending',
      'totalAmount': 28.75,
      'itemCount': 1,
    },
  ];

  Future<void> _refreshOrders() async {
    setState(() => isLoading = true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // If user is guest, show guest orders view
    if (authRepo.isGuest) {
      return const GuestOrdersView();
    }

    // If user is authenticated but has no orders
    if (orders.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: EmptyOrdersView(onHomeTap: widget.onHomeTap),
      );
    }

    // If user is authenticated and has orders
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: RefreshIndicator(
          color: AppColors.white,
          backgroundColor: AppColors.primary,
          onRefresh: _refreshOrders,
          child: ListView.builder(
            padding: EdgeInsets.all(20.w),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderCard(
                orderId: order['orderId'],
                date: order['date'],
                status: order['status'],
                totalAmount: order['totalAmount'],
                itemCount: order['itemCount'],
                onTap: () {
                  // Navigate to order details
                  // TODO: Implement order details view
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Order #${order['orderId']} details'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
