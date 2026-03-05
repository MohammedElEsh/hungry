import '../entities/product_detail_entity.dart';
import '../result.dart';

abstract class ProductDetailRepository {
  Future<Result<ProductDetailEntity>> getProduct(String id);
}
