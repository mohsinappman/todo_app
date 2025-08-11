import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/state/base_state.dart';
import '../../../../shared/utils/cubit_exception_handler_mixin.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/get_all_tasks_usecase.dart';

class GetTasksCubit extends Cubit<BaseState> with CubitExceptionHandlingMixin {
  final GetAllTasksUseCase getAllTasksUseCase;

  GetTasksCubit(this.getAllTasksUseCase) : super(const InitialState());

  Future<void> getAllTasks() async {
    emit(const LoadingState());

    try {
      final tasks = await getAllTasksUseCase();
      emit(SuccessState<List<TaskEntity>>(data: tasks));
    } catch (error) {
      handleException(error);
    }
  }

  void resetState() {
    emit(const InitialState());
  }
}
