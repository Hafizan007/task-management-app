import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../entities/task_entity.dart';
import '../params/get_task_params.dart';
import '../repositories/task_management_repository.dart';

@lazySingleton
class ListTaskUsecase implements UseCase<List<TaskEntity>, GetTaskParams> {
  final TaskManagementRepository repository;

  ListTaskUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<TaskEntity>>> call(GetTaskParams params) async {
    return repository.getTaskData(params);
  }
}
