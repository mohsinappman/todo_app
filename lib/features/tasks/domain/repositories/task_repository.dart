import '../../data/models/task_model.dart';
import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<void> createTask({required TaskModel task});
  Future<List<TaskEntity>> getAllTasks();
  Future<List<TaskEntity>> getTasksByCategory({required String categoryId});
  Future<void> updateTask({required TaskEntity task});
  Future<void> deleteTask({required String taskId});
  Future<void> toggleTaskCompletion({
    required String taskId,
    required bool isCompleted,
  });
}
