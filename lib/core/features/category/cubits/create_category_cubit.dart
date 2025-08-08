import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../state/base_state.dart';
import '../../../utils/cubit_exception_handler_mixin.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class CreateCategoryCubit extends Cubit<BaseState>
    with CubitExceptionHandlingMixin {
  CategoryService _categoryService;

  CreateCategoryCubit(this._categoryService) : super(InitialState());

  final supabase = Supabase.instance.client;

  Future<void> createCategory({required CategoryModel categoryModel}) async {
    emit(LoadingState());

    try {
      await _categoryService.createCategory(categoryModel: categoryModel);
      emit(SuccessState());
    } catch (error) {
      handleException(error);
    }
  }
}
