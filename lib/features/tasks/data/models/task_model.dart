import '../../../category/data/models/category_model.dart';
import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    super.id,
    super.fkUserId,
    super.title,
    super.description,
    super.imageUrl,
    super.dueDateTime,
    super.categoryId,
    super.category,
    super.taskPriority,
    super.isCompleted,
    super.createdAt,
    super.updatedAt,
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
      category: json['categories'] != null &&
          json['categories'] is Map<String, dynamic>
          ? CategoryModel.fromJson(json['categories'])
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
