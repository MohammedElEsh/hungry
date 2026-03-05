import '../../../../core/domain/result.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/cart_data.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_datasource.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remote;
  final NetworkInfo _networkInfo;

  CartItemEntity? _lastAddedItem;

  CartRepositoryImpl(this._remote, this._networkInfo);

  List<CartItemEntity> _modelsToEntities(List<CartItemModel> models) =>
      models
          .map((m) => CartItemEntity(
                id: m.id,
                productId: m.productId,
                name: m.name,
                price: m.price,
                quantity: m.quantity,
                priceDisplay: m.priceDisplay,
                image: m.image,
                spicy: m.spicy,
                toppingNames: m.toppingNames,
                sideOptionNames: m.sideOptionNames,
                toppingIds: m.toppingIds,
                sideOptionIds: m.sideOptionIds,
              ))
          .toList();

  List<CartItemEntity> _mergeLastAdded(List<CartItemEntity> entities) {
    final added = _lastAddedItem;
    if (added == null) return entities;
    _lastAddedItem = null;
    final list = List<CartItemEntity>.from(entities);
    for (var i = 0; i < list.length; i++) {
      if (list[i].productId == added.productId) {
        list[i] = CartItemEntity(
          id: list[i].id,
          productId: list[i].productId,
          name: list[i].name,
          price: list[i].price,
          quantity: list[i].quantity,
          priceDisplay: list[i].priceDisplay,
          image: list[i].image ?? added.image,
          spicy: added.spicy,
          toppingNames: added.toppingNames.isNotEmpty ? added.toppingNames : list[i].toppingNames,
          sideOptionNames: added.sideOptionNames.isNotEmpty ? added.sideOptionNames : list[i].sideOptionNames,
          toppingIds: added.toppingIds,
          sideOptionIds: added.sideOptionIds,
        );
        break;
      }
    }
    return list;
  }

  @override
  Future<Result<CartData>> getCartItems() async {
    if (!await _networkInfo.isConnected) {
      return const FailureResult(NetworkFailure('No connection'));
    }
    try {
      final response = await _remote.getCart();
      var entities = _modelsToEntities(response.items);
      entities = _mergeLastAdded(entities);
      return Success(CartData(
        items: entities,
        totalPriceFromApi: response.totalPrice,
      ));
    } on AuthException catch (_) {
      return Success(const CartData(items: []));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    }
  }

  @override
  Future<Result<void>> addToCart(CartItemEntity item) async {
    if (!await _networkInfo.isConnected) {
      return const FailureResult(NetworkFailure('No connection'));
    }
    try {
      _lastAddedItem = item;
      await _remote.addToCart(item);
      return const Success(null);
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    }
  }

  @override
  Future<Result<void>> removeFromCart(String itemId) async {
    if (!await _networkInfo.isConnected) {
      return const FailureResult(NetworkFailure('No connection'));
    }
    try {
      await _remote.removeFromCart(itemId);
      return const Success(null);
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    }
  }

  @override
  Future<Result<void>> clearCart() async {
    return const Success(null);
  }
}
