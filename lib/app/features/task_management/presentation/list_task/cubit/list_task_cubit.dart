import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/task_entity.dart';
import '../../../domain/params/delete_task_params.dart';
import '../../../domain/params/get_task_params.dart';
import '../../../domain/params/update_task_params.dart';
import '../../../domain/usecases/delete_task_usecase.dart';
import '../../../domain/usecases/list_task_usecase.dart';
import '../../../domain/usecases/update_task_usecase.dart';

part 'list_task_state.dart';

@injectable
class ListTaskCubit extends Cubit<ListTaskState> {
  final ListTaskUsecase listTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;

  ListTaskCubit({
    required this.listTaskUsecase,
    required this.updateTaskUsecase,
    required this.deleteTaskUsecase,
  }) : super(ListTaskInitial());

  List<TaskEntity> taskList = [];
  TaskStatus _currentFilter = TaskStatus.pending;

  Future<void> getListTask() async {
    emit(ListTaskLoading());

    final result = await listTaskUsecase(const GetTaskParams());

    result.fold(
      (failure) => emit(ListTaskFailure(message: failure.message)),
      (data) {
        taskList = data;

        filterByStatus(_currentFilter);
      },
    );
  }

  void filterByStatus(TaskStatus taskStatus) {
    _currentFilter = taskStatus;
    final filteredTaskList =
        taskList.where((task) => task.taskStatus == taskStatus).toList();

    emit(ListTaskSuccess(
      taskList: filteredTaskList,
      totalCompletedTask: taskList
          .where((task) => task.taskStatus == TaskStatus.completed)
          .length,
      totalTask: taskList.length,
      totalPendingTask: taskList
          .where((task) => task.taskStatus == TaskStatus.pending)
          .length,
    ));
  }

  Future<void> updateStatusTask({
    required String taskId,
    required TaskStatus taskStatus,
  }) async {
    emit(ListTaskLoading());

    final result = await updateTaskUsecase(
      UpdateTaskParams(
        id: taskId,
        taskStatus: taskStatus,
      ),
    );

    result.fold(
      (failure) => emit(ListTaskFailure(message: failure.message)),
      (data) => getListTask(),
    );
  }

  Future<void> deleteTask(String taskId) async {
    emit(ListTaskLoading());

    final result = await deleteTaskUsecase(
      DeleteTaskParams(id: taskId),
    );

    result.fold(
      (failure) => emit(ListTaskFailure(message: failure.message)),
      (data) => getListTask(),
    );
  }
}
