import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../entities/task_entity.dart';
import '../params/store_task_params.dart';
import '../repositories/task_management_repository.dart';

@lazySingleton
class StoreTaskUsecase implements UseCase<TaskEntity, StoreTaskParams> {
  final TaskManagementRepository repository;

  StoreTaskUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, TaskEntity>> call(StoreTaskParams params) async {
    return repository.storeTaskData(params);
  }
}
