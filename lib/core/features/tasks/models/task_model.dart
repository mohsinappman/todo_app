import '../../../features/category/models/category_model.dart';

class TaskModel {
  final String? id;
  final String? fkUserId;
  final String? title;
  final String? description;
  final String? imageUrl;
  final DateTime? dueDateTime;
  final String? categoryId;
  final CategoryModel? category;
  final int? taskPriority;
  final bool? isCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TaskModel({
    this.id,
    this.fkUserId,
    this.title,
    this.description,
    this.imageUrl,
    this.dueDateTime,
    this.categoryId,
    this.category,
    this.taskPriority,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String?,
      fkUserId: json['fk_user_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      dueDateTime: json['due_datetime'] != null
          ? DateTime.tryParse(json['due_datetime'])
          : null,
      categoryId: json['category_id'] as String?,
      category: json['categories'] != null && json['categories'] is Map<String, dynamic>
          ? CategoryModel.fromJson(json['categories'] as Map<String, dynamic>)
          : null,
      taskPriority: json['task_priority'] != null
          ? int.tryParse(json['task_priority'].toString())
          : null,
      isCompleted: json['is_completed'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'due_datetime': dueDateTime?.toIso8601String(),
      'category_id': categoryId,
      'task_priority': taskPriority,
      'is_completed': isCompleted ?? false,
    };
  }

  /// Use when creating a new task (excludes auto-generated fields)
  Map<String, dynamic> toCreateJson() {
    return {
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'due_datetime': dueDateTime?.toIso8601String(),
      'category_id': categoryId,
      'task_priority': taskPriority,
      'is_completed': false,
      'fk_user_id': fkUserId,
    };
  }
}
