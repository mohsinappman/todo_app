import '../repositories/task_repository.dart';

class ToggleTaskCompletionUseCase {
  final TaskRepository repository;

  ToggleTaskCompletionUseCase(this.repository);

  Future<void> call({
    required String taskId,
    required bool isCompleted,
  }) {
    return repository.toggleTaskCompletion(
      taskId: taskId,
      isCompleted: isCompleted,
    );
  }
}
