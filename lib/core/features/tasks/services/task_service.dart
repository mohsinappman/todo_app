import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/task_model.dart';

abstract class TaskService {
  Future createTask({
    required TaskModel task,
  });
  
  Future<List<TaskModel>> getAllTasks();
  Future<List<TaskModel>> getTasksByCategory({required String categoryId});
  Future<void> updateTask({required TaskModel taskModel});
  Future<void> deleteTask({required String taskId});
  Future<void> toggleTaskCompletion({required String taskId, required bool isCompleted});
}

class TaskServiceRepository implements TaskService {
  final SupabaseClient supabase;

  TaskServiceRepository(this.supabase);

  @override
  Future createTask({required TaskModel task}) async {
    try {
      final response = await supabase
          .from('todos')
          .insert(task.toCreateJson())
          .select()
          .single();

      log('Task created successfully: $response');
    } catch (e) {
      log('Error creating task: ${e.toString()}');
      throw Exception('Failed to create task: ${e.toString()}');
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final response = await supabase
          .from('todos')
          .select('''
            *,
            categories (
              id,
              name,
              color_hex,
              image_url
            )
          ''')
          .eq('fk_user_id', currentUser.id)
          .order('created_at', ascending: false);

      log('Fetched ${response.length} tasks for user: ${currentUser.id}');
      return response.map((item) => TaskModel.fromJson(item)).toList();
    } catch (e) {
      log('Error fetching tasks: ${e.toString()}');
      throw Exception('Failed to fetch tasks: ${e.toString()}');
    }
  }

  @override
  Future<List<TaskModel>> getTasksByCategory({required String categoryId}) async {
    try {
      // Get current user ID
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final response = await supabase
          .from('todos')
          .select('''
            *,
            categories (
              id,
              name,
              color_hex,
              image_url
            )
          ''')
          .eq('fk_user_id', currentUser.id)
          .eq('category_id', categoryId)
          .order('created_at', ascending: false);

      log('Fetched ${response.length} tasks for user: ${currentUser.id}, category: $categoryId');
      return response.map((item) => TaskModel.fromJson(item)).toList();
    } catch (e) {
      log('Error fetching tasks by category: ${e.toString()}');
      throw Exception('Failed to fetch tasks by category: ${e.toString()}');
    }
  }

  @override
  Future<void> updateTask({required TaskModel taskModel}) async {
    try {
      await supabase
          .from('todos')
          .update(taskModel.toJson())
          .eq('id', taskModel.id!);

      log('Task updated successfully: ${taskModel.id}');
    } catch (e) {
      log('Error updating task: ${e.toString()}');
      throw Exception('Failed to update task: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteTask({required String taskId}) async {
    try {
      await supabase
          .from('todos')
          .delete()
          .eq('id', taskId);

      log('Task deleted successfully: $taskId');
    } catch (e) {
      log('Error deleting task: ${e.toString()}');
      throw Exception('Failed to delete task: ${e.toString()}');
    }
  }

  @override
  Future<void> toggleTaskCompletion({
    required String taskId,
    required bool isCompleted,
  }) async {
    try {
      await supabase
          .from('todos')
          .update({'is_completed': isCompleted})
          .eq('id', taskId);

      log('Task completion toggled: $taskId -> $isCompleted');
    } catch (e) {
      log('Error toggling task completion: ${e.toString()}');
      throw Exception('Failed to toggle task completion: ${e.toString()}');
    }
  }
}
