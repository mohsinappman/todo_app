import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final SupabaseClient supabase;

  CategoryRepositoryImpl(this.supabase);

  @override
  Future<void> createCategory({required CategoryModel category}) async {
    try {
      await supabase.from('categories').insert(
        category.toJson(),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    try {
      final response = await supabase.from('categories').select();
      return response.map((item) => CategoryModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Error fetching categories: ${e.toString()}');
    }
  }
}
