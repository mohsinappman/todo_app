import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../state/base_state.dart';
import '../../../utils/cubit_exception_handler_mixin.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class GetCategoriesCubit extends Cubit<BaseState>
    with CubitExceptionHandlingMixin {
  final CategoryService _categoryService;

  GetCategoriesCubit(this._categoryService) : super(InitialState());

  final supabase = Supabase.instance.client;

  Future<void> getCategories() async {
    emit(LoadingState());

    try {
      final List<CategoryModel> categories = await _categoryService
          .getAllCategories();
      emit(SuccessState(data: categories));
    } catch (error) {
      handleException(error);
    }
  }
}
