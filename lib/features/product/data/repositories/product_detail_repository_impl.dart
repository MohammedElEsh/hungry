import '../../../../core/domain/result.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/product_detail_entity.dart';
import '../../domain/entities/side_option_entity.dart';
import '../../domain/entities/topping_entity.dart';
import '../../domain/repositories/product_detail_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';
import '../models/side_options_model.dart';
import '../models/topping_model.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository {
  final ProductDetailRemoteDataSource _remote;

  ProductDetailRepositoryImpl(this._remote);

  @override
  Future<Result<ProductDetailEntity>> getProduct(String id) async {
    try {
      final product = await _remote.getProductById(id);
      List<ToppingModel> toppings = [];
      List<SideOptionsModel> sideOptions = [];
      try {
        toppings = await _remote.getToppings();
      } catch (e) {
        AppLogger.w('Toppings fetch failed: $e');
      }
      try {
        sideOptions = await _remote.getSideOptions(id);
      } catch (e) {
        AppLogger.w('Side options fetch failed: $e');
      }
      final entity = _toEntity(product, toppings, sideOptions);
      return Success(entity);
    } catch (e) {
      try {
        final products = await _remote.getAllProducts();
        final idStr = id.toString();
        ProductModel? fallbackProduct;
        for (final p in products) {
          if (p.id.toString() == idStr || p.id == int.tryParse(idStr)) {
            fallbackProduct = p;
            break;
          }
        }
        if (fallbackProduct != null) {
          final entity = _toEntity(fallbackProduct, [], []);
          return Success(entity);
        }
      } catch (fallbackError) {
        AppLogger.w('Product fallback failed: $fallbackError');
      }
      return const FailureResult(ServerFailure('Product not found'));
    }
  }

  ProductDetailEntity _toEntity(
    ProductModel p,
    List<ToppingModel> toppings,
    List<SideOptionsModel> sideOptions,
  ) {
    final price = double.tryParse(p.price ?? '0') ?? 0.0;
    return ProductDetailEntity(
      id: (p.id ?? 0).toString(),
      name: p.name ?? '',
      price: price,
      description: p.description,
      image: p.image,
      toppings: toppings.map(_toppingToEntity).toList(),
      sideOptions: sideOptions.map(_sideOptionToEntity).toList(),
    );
  }

  ToppingEntity _toppingToEntity(ToppingModel m) => ToppingEntity(
        id: m.id,
        name: m.name,
        image: m.image,
      );

  SideOptionEntity _sideOptionToEntity(SideOptionsModel m) => SideOptionEntity(
        id: m.id,
        name: m.name,
        image: m.image,
      );
}
