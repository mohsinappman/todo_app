import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/features/category/domain/usecases/create_category_usecase.dart';

import 'data/repositories/category_repository_impl.dart';
import 'domain/usecases/get_all_categories_usecase.dart';

final supabaseClient = Supabase.instance.client;
final categoryRepository = CategoryRepositoryImpl(supabaseClient);
final createCategoryUsecase = CreateCategoryUseCase(categoryRepository);
final getAllCategoriesUseCase = GetAllCategoriesUseCase(categoryRepository);