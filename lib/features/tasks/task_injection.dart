import 'package:supabase_flutter/supabase_flutter.dart';

import 'data/repositories/task_repository_impl.dart';
import 'domain/usecases/create_task_usecase.dart';
import 'domain/usecases/delete_task_usecase.dart';
import 'domain/usecases/get_all_tasks_usecase.dart';
import 'domain/usecases/get_task_by_category_usecase.dart';
import 'domain/usecases/toggle_task_completion_usecase.dart';
import 'domain/usecases/update_task_usecase.dart';

final supabaseClient = Supabase.instance.client;
final taskRepository = TaskRepositoryImpl(supabaseClient);
final createTaskUsecase = CreateTaskUseCase(taskRepository);
final deleteTaskUsecase = DeleteTaskUseCase(taskRepository);
final getAllTasksUseCase = GetAllTasksUseCase(taskRepository);
final getTaskByCategoryUseCase = GetTasksByCategoryUseCase(taskRepository);
final toggleTaskCompletionUseCase = ToggleTaskCompletionUseCase(taskRepository);
final updateTaskUsecase = UpdateTaskUseCase(taskRepository);