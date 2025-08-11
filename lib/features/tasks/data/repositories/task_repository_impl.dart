import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final SupabaseClient supabase;

  TaskRepositoryImpl(this.supabase);

  @override
  Future<void> createTask({required TaskModel task}) async {
    try {
      await supabase
          .from('todos')
          .insert(task.toCreateJson())
          .select()
          .single();
    } catch (e) {
      log('Error creating task: $e');
      throw Exception('Failed to create task: $e');
    }
  }

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    try {
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) throw Exception('User not authenticated');

      final response = await supabase
          .from('todos')
          .select('*, categories(id, name, color_hex, image_url)')
          .eq('fk_user_id', currentUser.id)
          .order('created_at', ascending: false);

      return response.map((item) => TaskModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  @override
  Future<List<TaskEntity>> getTasksByCategory({required String categoryId}) async {
    try {
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) throw Exception('User not authenticated');

      final response = await supabase
          .from('todos')
          .select('*, categories(id, name, color_hex, image_url)')
          .eq('fk_user_id', currentUser.id)
          .eq('category_id', categoryId)
          .order('created_at', ascending: false);

      return response.map((item) => TaskModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to fetch tasks by category: $e');
    }
  }

  @override
  Future<void> updateTask({required TaskEntity task}) async {
    try {
      await supabase
          .from('todos')
          .update((task as TaskModel).toJson())
          .eq('id', task.id!);
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  @override
  Future<void> deleteTask({required String taskId}) async {
    try {
      await supabase.from('todos').delete().eq('id', taskId);
    } catch (e) {
      throw Exception('Failed to delete task: $e');
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
    } catch (e) {
      throw Exception('Failed to toggle task completion: $e');
    }
  }
}
