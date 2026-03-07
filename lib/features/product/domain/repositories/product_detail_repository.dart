import 'package:hungry/core/domain/result.dart';

import '../entities/product_detail_entity.dart';

abstract class ProductDetailRepository {
  Future<Result<ProductDetailEntity>> getProduct(String id);
}
