import '../repositories/task_repository.dart';
import '../entities/task_entity.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<void> call({required TaskEntity task}) {
    if (task.id == null) throw Exception('Task id is required for update');
    return repository.updateTask(task: task);
  }
}
