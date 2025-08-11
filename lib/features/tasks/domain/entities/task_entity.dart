import '../../../category/domain/entities/category_entity.dart';

class TaskEntity {
  final String? id;
  final String? fkUserId;
  final String? title;
  final String? description;
  final String? imageUrl;
  final DateTime? dueDateTime;
  final String? categoryId;
  final CategoryEntity? category;
  final int? taskPriority;
  final bool? isCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TaskEntity({
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
}
