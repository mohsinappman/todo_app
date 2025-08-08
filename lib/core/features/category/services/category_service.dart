import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/category_model.dart';

abstract class CategoryService {
  Future<void> createCategory({required CategoryModel categoryModel});
  Future<List<CategoryModel>> getAllCategories();
}

class CategoryServiceRepository implements CategoryService {
  final SupabaseClient supabase;

  CategoryServiceRepository(this.supabase);

  @override
  Future<void> createCategory({required CategoryModel categoryModel}) async {
    try {
      await supabase.from('categories').insert(categoryModel.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response = await supabase.from('categories').select();
      return response.map((item) => CategoryModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Error fetching categories: ${e.toString()}');
    }
  }
}
