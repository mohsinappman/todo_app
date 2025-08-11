import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/state/base_state.dart';
import '../../../../shared/utils/cubit_exception_handler_mixin.dart';
import '../../data/models/task_model.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/create_task_usecase.dart';

class CreateTaskCubit extends Cubit<BaseState>
    with CubitExceptionHandlingMixin {
  final CreateTaskUseCase createTaskUseCase;

  CreateTaskCubit(this.createTaskUseCase) : super(const InitialState());

  Future<void> createTask({required TaskModel task}) async {
    emit(const LoadingState());

    try {
      await createTaskUseCase(task: task);

      emit(SuccessState(data: 'success'));
    } catch (error) {
      handleException(error);
    }
  }

  void resetState() {
    emit(const InitialState());
  }
}
