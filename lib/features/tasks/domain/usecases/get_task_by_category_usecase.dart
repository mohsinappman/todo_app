import '../repositories/task_repository.dart';
import '../entities/task_entity.dart';

class GetTasksByCategoryUseCase {
  final TaskRepository repository;

  GetTasksByCategoryUseCase(this.repository);

  Future<List<TaskEntity>> call({required String categoryId}) {
    if (categoryId.trim().isEmpty) {
      throw Exception('categoryId is required');
    }
    return repository.getTasksByCategory(categoryId: categoryId);
  }
}
