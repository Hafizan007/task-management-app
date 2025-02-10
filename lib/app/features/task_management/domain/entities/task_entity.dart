import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskStatus taskStatus;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.taskStatus,
  });

  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    TaskStatus? taskStatus,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      taskStatus: taskStatus ?? this.taskStatus,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        dueDate,
        taskStatus,
      ];
}

enum TaskStatus {
  pending,
  inProgress,
  completed,
}

final taskStatusValues = {
  "in_progress": TaskStatus.inProgress,
  "completed": TaskStatus.completed,
  "pending": TaskStatus.pending
};

TaskStatus getTaskStatus(String status) {
  return taskStatusValues[status]!;
}

String getTaskStatusString(TaskStatus status) {
  return taskStatusValues.entries
      .firstWhere((element) => element.value == status)
      .key;
}
