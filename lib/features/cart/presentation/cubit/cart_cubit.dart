import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/usecases/get_cart_items_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItemsUseCase _getCartItemsUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final ClearCartUseCase _clearCartUseCase;

  bool _isLoading = false;

  CartCubit(
    this._getCartItemsUseCase,
    this._addToCartUseCase,
    this._removeFromCartUseCase,
    this._clearCartUseCase,
  ) : super(CartInitial());

  Future<void> loadCart() async {
    if (_isLoading) return;
    _isLoading = true;
    if (!isClosed) emit(const CartLoading());
    final result = await _getCartItemsUseCase();
    _isLoading = false;
    if (isClosed) return;
    result.when(
      success: (data) => emit(CartLoaded(List.from(data.items), totalPriceFromApi: data.totalPriceFromApi)),
      onFailure: (f) => emit(CartError(f.message)),
    );
  }

  /// Fetches cart and updates state without emitting CartLoading (for post add/remove/clear).
  Future<void> _refreshCart() async {
    final result = await _getCartItemsUseCase();
    if (isClosed) return;
    result.when(
      success: (data) => emit(CartLoaded(List.from(data.items), totalPriceFromApi: data.totalPriceFromApi)),
      onFailure: (f) => emit(CartError(f.message)),
    );
  }

  Future<void> addToCart(CartItemEntity item) async {
    final result = await _addToCartUseCase(item);
    if (isClosed) return;
    result.when(
      success: (_) => _refreshCart(),
      onFailure: (f) => emit(CartError(f.message)),
    );
  }

  Future<void> removeFromCart(String id) async {
    if (id.isEmpty) return;
    final state = this.state;
    if (state is! CartLoaded) return;
    if (state.removingItemId == id) return;
    final newItems = state.items.where((i) => i.id != id).toList();
    if (newItems.length == state.items.length) return;
    if (!isClosed) {
      emit(CartLoaded(newItems, totalPriceFromApi: null));
    }
    final result = await _removeFromCartUseCase(id);
    if (isClosed) return;
    result.when(
      success: (_) => _refreshCart(),
      onFailure: (f) {
        if (!isClosed) loadCart();
        if (!isClosed) emit(CartError(f.message));
      },
    );
  }

  Future<void> clearCart() async {
    final result = await _clearCartUseCase();
    if (isClosed) return;
    result.when(
      success: (_) => _refreshCart(),
      onFailure: (f) => emit(CartError(f.message)),
    );
  }
}
