import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/data/models/sync_queue_model.dart';
import '../../../../config/networking/app_exception.dart';
import '../../../../config/networking/failure.dart';
import '../../../../config/networking/network_info.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/params/delete_task_params.dart';
import '../../domain/params/get_task_params.dart';
import '../../domain/params/store_task_params.dart';
import '../../domain/params/update_task_params.dart';
import '../../domain/repositories/task_management_repository.dart';
import '../datasouce/local/task_management_local_datasource.dart';
import '../datasouce/remote/task_management_remote_datasource.dart';
import '../models/task_delete_request_model.dart';
import '../models/task_get_request_model.dart';
import '../models/task_store_request_model.dart';
import '../models/task_update_request_model.dart';

@LazySingleton(as: TaskManagementRepository)
class TaskManagementRepositoryImpl implements TaskManagementRepository {
  final TaskManagementLocalDataSource localDataSource;
  final TaskManagementRemoteDataSource remoteDatasource;
  final NetworkInfo networkInfo;

  TaskManagementRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo,
    required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, void>> storeTaskData(StoreTaskParams params) async {
    try {
      final taskModel = TaskStoreRequestModel.fromDomain(params);
      await localDataSource.storeTaskManagementData(taskModel);

      if (await networkInfo.isConnected) {
        await remoteDatasource.storeTaskData(taskModel);
      } else {
        await localDataSource.addToSyncQueue(
          SyncQueueModel(
            id: Random().nextInt(1000).toString(),
            operation: 'CREATE',
            data: taskModel.toJson(),
          ),
        );
      }
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTaskData(
    GetTaskParams params,
  ) async {
    try {
      final requestModel = TaskGetRequestModel.fromDomain(params);
      final tasks = await localDataSource.getTaskManagementData(requestModel);

      return Right(tasks.map((task) => task.toDomain()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTaskData(UpdateTaskParams params) async {
    try {
      final requestModel = TaskUpdateRequestModel.fromDomain(params);

      await localDataSource.updateTaskManagementData(requestModel);

      if (await networkInfo.isConnected) {
        await remoteDatasource.updateTaskData(requestModel);
      } else {
        await localDataSource.addToSyncQueue(
          SyncQueueModel(
            id: Random().nextInt(1000).toString(),
            operation: 'UPDATE',
            data: requestModel.toJson(),
          ),
        );
      }

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTaskData(DeleteTaskParams params) async {
    try {
      final requestModel = TaskDeleteRequestModel.fromDomain(params);
      await localDataSource.deleteTaskManagementData(requestModel);

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<void> syncData() async {
    if (!await networkInfo.isConnected) return;

    final queue = await localDataSource.getSyncQueue();

    for (final item in queue) {
      try {
        switch (item.operation) {
          case 'CREATE':
            final taskModel = TaskStoreRequestModel.fromJson(item.data);
            await remoteDatasource.storeTaskData(taskModel);
            break;
          case 'UPDATE':
            final taskModel = TaskUpdateRequestModel.fromJson(item.data);
            await remoteDatasource.updateTaskData(taskModel);
            break;
        }
        await localDataSource.removeSyncQueueItem(item.id);
      } catch (e) {
        return;
      }
    }
  }
}
