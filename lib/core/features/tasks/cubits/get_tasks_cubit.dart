import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../state/base_state.dart';
import '../../../utils/cubit_exception_handler_mixin.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class GetTasksCubit extends Cubit<BaseState> with CubitExceptionHandlingMixin {
  final TaskService _taskService;

  GetTasksCubit(this._taskService) : super(const InitialState());

  Future<void> getAllTasks() async {
    emit(const LoadingState());

    try {
      final tasks = await _taskService.getAllTasks();
      emit(SuccessState<List<TaskModel>>(data: tasks));
    } catch (error) {
      handleException(error);
    }
  }

  Future<void> getTasksByCategory({required String categoryId}) async {
    emit(const LoadingState());

    try {
      final tasks = await _taskService.getTasksByCategory(
        categoryId: categoryId,
      );
      emit(SuccessState<List<TaskModel>>(data: tasks));
    } catch (error) {
      handleException(error);
    }
  }

  void resetState() {
    emit(const InitialState());
  }
}
