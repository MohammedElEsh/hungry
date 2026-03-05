part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductDetailEntity product;
  final int quantity;
  final double spicyLevel;
  final Set<int> selectedToppingIds;
  final Set<int> selectedSideOptionIds;
  final bool isAddingToCart;
  final bool? addToCartSuccess;
  final String? addToCartError;

  const ProductLoaded(
    this.product, {
    this.quantity = 1,
    this.spicyLevel = 0.6,
    this.selectedToppingIds = const {},
    this.selectedSideOptionIds = const {},
    this.isAddingToCart = false,
    this.addToCartSuccess,
    this.addToCartError,
  });

  ProductLoaded copyWith({
    ProductDetailEntity? product,
    int? quantity,
    double? spicyLevel,
    Set<int>? selectedToppingIds,
    Set<int>? selectedSideOptionIds,
    bool? isAddingToCart,
    bool? addToCartSuccess,
    String? addToCartError,
  }) {
    return ProductLoaded(
      product ?? this.product,
      quantity: quantity ?? this.quantity,
      spicyLevel: spicyLevel ?? this.spicyLevel,
      selectedToppingIds: selectedToppingIds ?? this.selectedToppingIds,
      selectedSideOptionIds: selectedSideOptionIds ?? this.selectedSideOptionIds,
      isAddingToCart: isAddingToCart ?? this.isAddingToCart,
      addToCartSuccess: addToCartSuccess ?? this.addToCartSuccess,
      addToCartError: addToCartError ?? this.addToCartError,
    );
  }

  @override
  List<Object?> get props => [
        product,
        quantity,
        spicyLevel,
        selectedToppingIds,
        selectedSideOptionIds,
        isAddingToCart,
        addToCartSuccess,
        addToCartError,
      ];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
