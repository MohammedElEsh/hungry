part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final Set<int> favoriteIds;
  final UserEntity? user;
  final int selectedCategoryIndex;

  const HomeLoaded({
    required this.products,
    required this.categories,
    required this.favoriteIds,
    this.user,
    this.selectedCategoryIndex = 0,
  });

  @override
  List<Object?> get props =>
      [products, categories, favoriteIds, user, selectedCategoryIndex];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
