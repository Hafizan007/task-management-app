import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../params/update_task_params.dart';
import '../repositories/task_management_repository.dart';

@lazySingleton
class UpdateTaskUsecase implements UseCase<void, UpdateTaskParams> {
  final TaskManagementRepository repository;

  UpdateTaskUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(UpdateTaskParams params) async {
    return repository.updateTaskData(params);
  }
}
