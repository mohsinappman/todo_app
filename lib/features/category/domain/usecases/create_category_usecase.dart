import '../../data/models/category_model.dart';
import '../repositories/category_repository.dart';

class CreateCategoryUseCase {
  final CategoryRepository repository;

  CreateCategoryUseCase(this.repository);

  Future<void> call(CategoryModel category) {
    return repository.createCategory(category: category);
  }
}
