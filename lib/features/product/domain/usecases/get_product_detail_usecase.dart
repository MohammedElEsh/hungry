import 'package:hungry/core/domain/result.dart';

import '../entities/product_detail_entity.dart';
import '../repositories/product_detail_repository.dart';

class GetProductDetailUseCase {
  final ProductDetailRepository _repository;

  GetProductDetailUseCase(this._repository);

  Future<Result<ProductDetailEntity>> call(String id) =>
      _repository.getProduct(id);
}
