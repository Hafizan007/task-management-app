import '../../domain/entities/task_entity.dart';
import '../../domain/params/update_task_params.dart';

class TaskUpdateRequestModel {
  TaskUpdateRequestModel({
    required this.id,
    required this.status,
  });

  final String id;
  final String status;

  factory TaskUpdateRequestModel.fromDomain(UpdateTaskParams params) {
    return TaskUpdateRequestModel(
      id: params.id,
      status: getTaskStatusString(params.taskStatus),
    );
  }

  factory TaskUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return TaskUpdateRequestModel(
      id: json["id"],
      status: json["taskStatus"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "taskStatus": status,
      };
}
