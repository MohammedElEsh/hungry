import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../cart/domain/usecases/add_to_cart_usecase.dart';
import '../../domain/entities/product_detail_entity.dart';
import '../../domain/usecases/get_product_detail_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductDetailUseCase _getProductDetailUseCase;
  final AddToCartUseCase _addToCartUseCase;

  ProductCubit(this._getProductDetailUseCase, this._addToCartUseCase)
      : super(ProductInitial());

  Future<void> loadProduct(String id) async {
    if (isClosed) return;
    emit(ProductLoading());
    final result = await _getProductDetailUseCase(id);
    if (isClosed) return;
    result.when(
      success: (product) {
        if (!isClosed) emit(ProductLoaded(product));
      },
      onFailure: (f) {
        if (!isClosed) emit(ProductError(f.message));
      },
    );
  }

  void setQuantity(int qty) {
    final current = state;
    if (current is ProductLoaded && qty >= 1 && !isClosed) {
      emit(current.copyWith(quantity: qty));
    }
  }

  void setSpicyLevel(double level) {
    final current = state;
    if (current is ProductLoaded && !isClosed) {
      emit(current.copyWith(spicyLevel: level.clamp(0.0, 1.0)));
    }
  }

  void toggleTopping(int id) {
    final current = state;
    if (current is! ProductLoaded || isClosed) return;
    final next = Set<int>.from(current.selectedToppingIds);
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    emit(current.copyWith(selectedToppingIds: next));
  }

  void toggleSideOption(int id) {
    final current = state;
    if (current is! ProductLoaded || isClosed) return;
    final next = Set<int>.from(current.selectedSideOptionIds);
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    emit(current.copyWith(selectedSideOptionIds: next));
  }

  Future<void> addToCart() async {
    final current = state;
    if (current is! ProductLoaded || current.isAddingToCart || isClosed) {
      return;
    }
    if (!isClosed) emit(current.copyWith(isAddingToCart: true));
    final product = current.product;
    final toppingNames = product.toppings
        .where((t) => current.selectedToppingIds.contains(t.id))
        .map((t) => t.name)
        .toList();
    final sideOptionNames = product.sideOptions
        .where((s) => current.selectedSideOptionIds.contains(s.id))
        .map((s) => s.name)
        .toList();
    final toppingIds = current.selectedToppingIds.toList();
    final sideOptionIds = current.selectedSideOptionIds.toList();
    final item = CartItemEntity(
      id: '${product.id}_${DateTime.now().millisecondsSinceEpoch}',
      productId: product.id,
      name: product.name,
      price: product.price * current.quantity,
      quantity: current.quantity,
      image: product.image,
      spicy: current.spicyLevel,
      toppingNames: toppingNames,
      sideOptionNames: sideOptionNames,
      toppingIds: toppingIds,
      sideOptionIds: sideOptionIds,
    );
    final result = await _addToCartUseCase(item);
    if (isClosed) return;
    result.when(
      success: (_) {
        if (!isClosed) {
          emit(current.copyWith(
              isAddingToCart: false, addToCartSuccess: true, addToCartError: null));
        }
      },
      onFailure: (f) {
        if (!isClosed) {
          emit(current.copyWith(
              isAddingToCart: false, addToCartSuccess: false, addToCartError: f.message));
        }
      },
    );
  }

  void clearAddToCartResult() {
    if (isClosed) return;
    final current = state;
    if (current is ProductLoaded) {
      emit(ProductLoaded(
        current.product,
        quantity: current.quantity,
        spicyLevel: current.spicyLevel,
        selectedToppingIds: current.selectedToppingIds,
        selectedSideOptionIds: current.selectedSideOptionIds,
        addToCartSuccess: null,
        addToCartError: null,
      ));
    }
  }
}
