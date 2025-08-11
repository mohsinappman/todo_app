import '../repositories/task_repository.dart';
import '../entities/task_entity.dart';

class GetAllTasksUseCase {
  final TaskRepository repository;

  GetAllTasksUseCase(this.repository);

  Future<List<TaskEntity>> call() {
    return repository.getAllTasks();
  }
}
