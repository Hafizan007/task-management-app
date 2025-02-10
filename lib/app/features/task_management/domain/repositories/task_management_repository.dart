import 'package:dartz/dartz.dart';

import '../../../../config/networking/failure.dart';
import '../entities/task_entity.dart';
import '../params/delete_task_params.dart';
import '../params/get_task_params.dart';
import '../params/store_task_params.dart';
import '../params/update_task_params.dart';

abstract class TaskManagementRepository {
  Future<Either<Failure, void>> storeTaskData(StoreTaskParams taskModel);
  Future<Either<Failure, List<TaskEntity>>> getTaskData(GetTaskParams params);
  Future<Either<Failure, void>> updateTaskData(UpdateTaskParams params);
  Future<Either<Failure, void>> deleteTaskData(DeleteTaskParams params);
  Future<void> syncData();
}
