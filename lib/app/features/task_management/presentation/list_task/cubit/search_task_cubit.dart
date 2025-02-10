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

part 'search_task_state.dart';

@injectable
class SearchTaskCubit extends Cubit<SearchTaskState> {
  final ListTaskUsecase listTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;

  SearchTaskCubit({
    required this.listTaskUsecase,
    required this.updateTaskUsecase,
    required this.deleteTaskUsecase,
  }) : super(SearchTaskInitial());

  Future<void> searchTask({String? searchQuery}) async {
    emit(SearchTaskLoading());

    final result = await listTaskUsecase(
      GetTaskParams(searchQuery: searchQuery),
    );

    result.fold(
      (failure) => emit(SearchTaskFailure(message: failure.message)),
      (taskList) => emit(SearchTaskSuccess(taskList: taskList)),
    );
  }

  Future<void> updateStatusTask({
    required String taskId,
    required TaskStatus taskStatus,
  }) async {
    emit(SearchTaskLoading());

    final result = await updateTaskUsecase(
      UpdateTaskParams(
        id: taskId,
        taskStatus: taskStatus,
      ),
    );

    result.fold(
      (failure) => emit(SearchTaskFailure(message: failure.message)),
      (data) => searchTask(),
    );
  }

  Future<void> deleteTask(String taskId) async {
    emit(SearchTaskLoading());

    final result = await deleteTaskUsecase(
      DeleteTaskParams(id: taskId),
    );

    result.fold(
      (failure) => emit(SearchTaskFailure(message: failure.message)),
      (data) => searchTask(),
    );
  }
}
