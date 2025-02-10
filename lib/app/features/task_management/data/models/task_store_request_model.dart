import 'package:uuid/uuid.dart';

import '../../domain/params/store_task_params.dart';

class TaskStoreRequestModel {
  final String title;
  final String description;
  final DateTime dueDate;
  final String taskStatus;

  TaskStoreRequestModel({
    required this.title,
    required this.description,
    required this.dueDate,
    this.taskStatus = 'pending',
  });

  factory TaskStoreRequestModel.fromDomain(StoreTaskParams params) {
    return TaskStoreRequestModel(
      title: params.title,
      description: params.description,
      dueDate: params.dueDate,
    );
  }

  factory TaskStoreRequestModel.fromJson(Map<String, dynamic> json) {
    return TaskStoreRequestModel(
      title: json['title'],
      description: json['description'],
      taskStatus: json['taskStatus'],
      dueDate: DateTime.parse(json['dueDate']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': const Uuid().v4(),
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'taskStatus': taskStatus,
      };
}
