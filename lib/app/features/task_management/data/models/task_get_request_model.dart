import '../../domain/entities/task_entity.dart';
import '../../domain/params/get_task_params.dart';

class TaskGetRequestModel {
  final String? taskStatus;
  final String? searchQuery;

  TaskGetRequestModel({
    this.taskStatus,
    this.searchQuery,
  });

  factory TaskGetRequestModel.fromDomain(GetTaskParams params) {
    return TaskGetRequestModel(
      taskStatus: params.taskStatus != null
          ? getTaskStatusString(params.taskStatus!)
          : null,
      searchQuery: params.searchQuery,
    );
  }
}
