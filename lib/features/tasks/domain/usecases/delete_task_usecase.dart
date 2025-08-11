import '../repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<void> call({required String taskId}) {
    if (taskId.trim().isEmpty) throw Exception('taskId is required');
    return repository.deleteTask(taskId: taskId);
  }
}
