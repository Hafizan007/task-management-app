import 'package:equatable/equatable.dart';

import '../entities/task_entity.dart';

class UpdateTaskParams extends Equatable {
  final String id;
  final TaskStatus taskStatus;

  const UpdateTaskParams({
    required this.id,
    required this.taskStatus,
  });

  @override
  List<Object?> get props => [id, taskStatus];
}
