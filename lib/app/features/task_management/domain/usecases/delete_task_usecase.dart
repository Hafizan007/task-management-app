import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../params/delete_task_params.dart';
import '../repositories/task_management_repository.dart';

@lazySingleton
class DeleteTaskUsecase implements UseCase<void, DeleteTaskParams> {
  final TaskManagementRepository repository;

  DeleteTaskUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(DeleteTaskParams params) async {
    return repository.deleteTaskData(params);
  }
}
