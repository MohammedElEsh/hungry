import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/domain/usecases/get_cached_user_usecase.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_orders_usecase.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  final GetCachedUserUseCase _getCachedUserUseCase;

  OrdersCubit(this._getOrdersUseCase, this._getCachedUserUseCase)
      : super(OrdersInitial());

  Future<void> loadOrders() async {
    if (isClosed) return;
    final userResult = await _getCachedUserUseCase();
    userResult.when(
      success: (user) async {
        if (user == null && !isClosed) {
          emit(OrdersGuest());
          return;
        }
        await _fetchOrders();
      },
      onFailure: (_) async {
        if (!isClosed) emit(OrdersGuest());
      },
    );
  }

  Future<void> _fetchOrders() async {
    if (isClosed) return;
    emit(OrdersLoading());
    final result = await _getOrdersUseCase();
    if (isClosed) return;
    result.when(
      success: (orders) => emit(OrdersLoaded(orders)),
      onFailure: (f) => emit(OrdersError(
        f.message == 'Network error'
            ? 'Could not load orders. Please check your connection.'
            : 'Could not load orders. Please try again.',
      )),
    );
  }

  Future<void> refresh() async {
    if (state is OrdersGuest || isClosed) return;
    await _fetchOrders();
  }
}
