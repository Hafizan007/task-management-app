import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:management_app/app/features/task_management/data/models/task_model.dart';
import 'package:management_app/app/features/task_management/data/repositories/task_management_repository_impl.dart';
import 'package:management_app/app/features/task_management/domain/entities/task_entity.dart';
import 'package:management_app/app/features/task_management/domain/params/store_task_params.dart';
import 'package:management_app/app/features/task_management/domain/params/update_task_params.dart';
import 'package:management_app/app/features/task_management/domain/repositories/task_management_repository.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mock_container.mocks.dart';

void main() {
  late TaskManagementRepository repository;
  late MockTaskManagementLocalDataSource mockLocalDataSource;
  late MockTaskManagementRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockTaskManagementLocalDataSource();
    mockRemoteDataSource = MockTaskManagementRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TaskManagementRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDatasource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
  group('storeTaskData', () {
    final params = StoreTaskParams(
      title: 'title',
      description: 'description',
      dueDate: DateTime.now(),
    );

    final taskModel = TaskModel(
      id: '1',
      taskStatus: 'pending',
      title: 'title',
      description: 'description',
      dueDate: DateTime.now(),
    );

    test(
        'should return TaskEntity when store task is successful and internet connetcted',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.storeTaskData(any)).thenAnswer((_) async => {});
      when(mockLocalDataSource.storeTaskManagementData(any))
          .thenAnswer((_) async => taskModel);

      final result = await repository.storeTaskData(params);

      expect(result, Right(taskModel.toDomain()));

      verify(mockRemoteDataSource.storeTaskData(any));
      verify(mockLocalDataSource.storeTaskManagementData(any));
    });
  });

  group('updateTaskData', () {
    const params = UpdateTaskParams(
      id: '1',
      taskStatus: TaskStatus.inProgress,
    );

    test(
        'should return TaskEntity when update task is successful and internet connetcted',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateTaskData(any))
          .thenAnswer((_) async => {});
      when(mockLocalDataSource.updateTaskManagementData(any))
          .thenAnswer((_) async => {});

      final result = await repository.updateTaskData(params);

      expect(result, const Right(null));

      verify(mockRemoteDataSource.updateTaskData(any));
      verify(mockLocalDataSource.updateTaskManagementData(any));
    });
  });
}
