part of 'list_task_cubit.dart';

abstract class ListTaskState extends Equatable {
  const ListTaskState();

  @override
  List<Object> get props => [];
}

class ListTaskInitial extends ListTaskState {}

class ListTaskLoading extends ListTaskState {}

class ListTaskSuccess extends ListTaskState {
  final List<TaskEntity> taskList;
  final int totalTask;
  final int totalCompletedTask;
  final int totalPendingTask;

  const ListTaskSuccess({
    required this.taskList,
    required this.totalTask,
    required this.totalCompletedTask,
    required this.totalPendingTask,
  });

  @override
  List<Object> get props => [taskList];
}

class ListTaskFailure extends ListTaskState {
  final String message;

  const ListTaskFailure({required this.message});

  @override
  List<Object> get props => [message];
}
