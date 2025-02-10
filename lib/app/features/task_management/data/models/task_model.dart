import 'package:json_annotation/json_annotation.dart';

import '../../../../config/networking/response_mapper.dart';
import '../../domain/entities/task_entity.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel implements ResponseMapper<TaskEntity> {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String taskStatus;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.taskStatus,
  });

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      dueDate: entity.dueDate,
      taskStatus: getTaskStatusString(entity.taskStatus),
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  @override
  TaskEntity toDomain() {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      dueDate: dueDate,
      taskStatus: getTaskStatus(taskStatus),
    );
  }
}
