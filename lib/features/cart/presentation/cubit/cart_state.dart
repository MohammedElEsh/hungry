part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;
  /// Total from API when present; otherwise UI may fall back to summing items.
  final String? totalPriceFromApi;
  /// ID of item currently being removed; show loading on that item.
  final String? removingItemId;

  const CartLoaded(this.items, {this.totalPriceFromApi, this.removingItemId});

  @override
  List<Object?> get props => [items, totalPriceFromApi, removingItemId];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
