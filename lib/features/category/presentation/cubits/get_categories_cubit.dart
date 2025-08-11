import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/state/base_state.dart';
import '../../../../shared/utils/cubit_exception_handler_mixin.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/get_all_categories_usecase.dart';

class GetCategoriesCubit extends Cubit<BaseState>
    with CubitExceptionHandlingMixin {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;

  GetCategoriesCubit(this.getAllCategoriesUseCase) : super(InitialState());

  Future<void> getCategories() async {
    emit(LoadingState());

    try {
      final List<CategoryEntity> categories = await getAllCategoriesUseCase();
      emit(SuccessState(data: categories));
    } catch (error) {
      handleException(error);
    }
  }
}
