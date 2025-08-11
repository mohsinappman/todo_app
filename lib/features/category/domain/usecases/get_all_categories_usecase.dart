import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetAllCategoriesUseCase {
  final CategoryRepository repository;

  GetAllCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call() async {
    return repository.getAllCategories();
  }
}
