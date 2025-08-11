import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/state/base_state.dart';
import '../../../../shared/utils/cubit_exception_handler_mixin.dart';
import '../../data/models/category_model.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/create_category_usecase.dart';


class CreateCategoryCubit extends Cubit<BaseState>
    with CubitExceptionHandlingMixin {
  final CreateCategoryUseCase createCategoryUseCase;

  CreateCategoryCubit(this.createCategoryUseCase) : super(InitialState());

  Future<void> createCategory({required CategoryModel category}) async {
    emit(LoadingState());

    try {
      await createCategoryUseCase(category);
      emit(SuccessState());
    } catch (error) {
      handleException(error);
    }
  }
}
