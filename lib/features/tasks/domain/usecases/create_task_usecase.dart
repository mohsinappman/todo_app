import '../../data/models/task_model.dart';
import '../repositories/task_repository.dart';

class CreateTaskUseCase {
  final TaskRepository repository;

  CreateTaskUseCase(this.repository);

  Future<void> call({required TaskModel task}) async {
    await repository.createTask(task: task);
  }
}
