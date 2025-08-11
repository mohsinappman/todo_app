import 'package:todo_app/features/category/domain/entities/category_entity.dart';

import '../../data/models/category_model.dart';


abstract class CategoryRepository {
  Future<void> createCategory({required CategoryModel category});
  Future<List<CategoryEntity>> getAllCategories();
}