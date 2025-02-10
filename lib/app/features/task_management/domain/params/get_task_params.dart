import 'package:equatable/equatable.dart';

import '../entities/task_entity.dart';

class GetTaskParams extends Equatable {
  final TaskStatus? taskStatus;
  final String? searchQuery;

  const GetTaskParams({
    this.taskStatus,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [taskStatus, searchQuery];
}
