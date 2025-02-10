import '../../domain/params/delete_task_params.dart';

class TaskDeleteRequestModel {
  TaskDeleteRequestModel({
    required this.id,
  });

  final String id;

  factory TaskDeleteRequestModel.fromDomain(DeleteTaskParams params) {
    return TaskDeleteRequestModel(
      id: params.id,
    );
  }
}
