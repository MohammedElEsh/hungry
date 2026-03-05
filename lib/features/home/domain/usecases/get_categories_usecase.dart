import 'package:hungry/core/domain/result.dart';

import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<Result<List<CategoryEntity>>> call() => _repository.getCategories();
}
