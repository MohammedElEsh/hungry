import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/result.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/domain/usecases/get_cached_user_usecase.dart';
import '../../../profile/domain/entities/profile_entity.dart';
import '../../../profile/domain/usecases/get_profile_usecase.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_favorites_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetFavoritesUseCase _getFavoritesUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final GetCachedUserUseCase _getCachedUserUseCase;
  final GetProfileUseCase _getProfileUseCase;

  bool _isLoading = false;

  HomeCubit(
    this._getProductsUseCase,
    this._getCategoriesUseCase,
    this._getFavoritesUseCase,
    this._toggleFavoriteUseCase,
    this._getCachedUserUseCase,
    this._getProfileUseCase,
  ) : super(const HomeInitial());

  static UserEntity? _userFromProfile(ProfileEntity? p) {
    if (p == null) return null;
    return UserEntity(
      id: p.id,
      email: p.email,
      name: p.name.isNotEmpty ? p.name : null,
      address: p.address,
      visa: p.visa,
      image: p.image?.isNotEmpty == true ? p.image : null,
    );
  }

  Future<void> loadHomeData() async {
    if (_isLoading) return;
    _isLoading = true;
    final hadData = state is HomeLoaded;
    if (!hadData && !isClosed) emit(const HomeLoading());
    final productsResult = await _getProductsUseCase();
    final categoriesResult = await _getCategoriesUseCase();
    final userResult = await _getCachedUserUseCase();
    final favResult = await _getFavoritesUseCase();
    if (isClosed) return;
    List<ProductEntity> products = [];
    List<CategoryEntity> categories = [];
    UserEntity? user;
    Set<int> favIds = {};
    productsResult.when(
      success: (p) => products = p,
      onFailure: (_) {},
    );
    categoriesResult.when(
      success: (c) => categories = c,
      onFailure: (_) {},
    );
    userResult.when(
      success: (u) => user = u,
      onFailure: (_) {},
    );
    final profileResult = await _getProfileUseCase();
    profileResult.when(
      success: (p) {
        final fromProfile = _userFromProfile(p);
        if (fromProfile != null) user = fromProfile;
      },
      onFailure: (_) {},
    );
    favResult.when(
      success: (ids) => favIds = ids.toSet(),
      onFailure: (_) {},
    );
    _isLoading = false;
    if (productsResult case FailureResult()) {
      if (!isClosed) emit(HomeError('Failed to load products'));
      return;
    }
    if (!isClosed) {
      emit(HomeLoaded(
        products: products,
        categories: categories,
        favoriteIds: favIds,
        user: user,
        selectedCategoryIndex: 0,
      ));
    }
  }

  /// Full refresh: show loading then fetch all data (like first open).
  Future<void> refresh() async {
    _isLoading = false;
    if (!isClosed) emit(const HomeLoading());
    await loadHomeData();
  }

  Future<void> toggleFavorite(int productId) async {
    final current = state;
    if (current is! HomeLoaded) return;
    final wasFavorite = current.favoriteIds.contains(productId);
    final newFavIds = Set<int>.from(current.favoriteIds);
    if (wasFavorite) {
      newFavIds.remove(productId);
    } else {
      newFavIds.add(productId);
    }
    if (!isClosed) {
      emit(HomeLoaded(
        products: current.products,
        categories: current.categories,
        favoriteIds: newFavIds,
        user: current.user,
        selectedCategoryIndex: current.selectedCategoryIndex,
      ));
    }
    final result = await _toggleFavoriteUseCase(productId);
    if (isClosed) return;
    result.when(
      success: (_) {},
      onFailure: (_) {
        if (!isClosed && state is HomeLoaded) {
          final s = state as HomeLoaded;
          final reverted = Set<int>.from(s.favoriteIds);
          if (wasFavorite) {
            reverted.add(productId);
          } else {
            reverted.remove(productId);
          }
          emit(HomeLoaded(
            products: s.products,
            categories: s.categories,
            favoriteIds: reverted,
            user: s.user,
            selectedCategoryIndex: s.selectedCategoryIndex,
          ));
        }
      },
    );
  }

  void selectCategory(int index) {
    final current = state;
    if (current is HomeLoaded && !isClosed) {
      emit(HomeLoaded(
        products: current.products,
        categories: current.categories,
        favoriteIds: current.favoriteIds,
        user: current.user,
        selectedCategoryIndex: index,
      ));
    }
  }
}
