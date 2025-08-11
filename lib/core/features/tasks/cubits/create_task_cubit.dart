import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../state/base_state.dart';
import '../../../utils/cubit_exception_handler_mixin.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class CreateTaskCubit extends Cubit<BaseState>
    with CubitExceptionHandlingMixin {
  final TaskService _taskService;

  CreateTaskCubit(this._taskService) : super(const InitialState());

  Future<void> createTask({required TaskModel task}) async {
    emit(const LoadingState());

    try {
      final createdTask = await _taskService.createTask(task: task);

      emit(SuccessState<TaskModel>(data: createdTask));
    } catch (error) {
      handleException(error);
    }
  }

  void resetState() {
    emit(const InitialState());
  }
}
