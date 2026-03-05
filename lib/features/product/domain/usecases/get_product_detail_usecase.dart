import '../entities/product_detail_entity.dart';
import '../repositories/product_detail_repository.dart';
import '../result.dart';

class GetProductDetailUseCase {
  final ProductDetailRepository _repository;

  GetProductDetailUseCase(this._repository);

  Future<Result<ProductDetailEntity>> call(String id) =>
      _repository.getProduct(id);
}
