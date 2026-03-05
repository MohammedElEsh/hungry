import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/error_display_widget.dart';
import '../cubit/cart_cubit.dart';

/// Cart error state: message + retry.
class CartErrorView extends StatelessWidget {
  final String message;

  const CartErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return ErrorDisplayWidget(
      message: message,
      onRetry: () => context.read<CartCubit>().loadCart(),
    );
  }
}
