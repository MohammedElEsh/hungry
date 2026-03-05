import 'package:hungry/core/domain/result.dart';

import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Result<List<ProductEntity>>> getProducts();
}
