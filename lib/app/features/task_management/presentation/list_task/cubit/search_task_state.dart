part of 'search_task_cubit.dart';

abstract class SearchTaskState extends Equatable {
  const SearchTaskState();

  @override
  List<Object> get props => [];
}

class SearchTaskInitial extends SearchTaskState {}

class SearchTaskLoading extends SearchTaskState {}

class SearchTaskSuccess extends SearchTaskState {
  final List<TaskEntity> taskList;

  const SearchTaskSuccess({
    required this.taskList,
  });

  @override
  List<Object> get props => [taskList];
}

class SearchTaskFailure extends SearchTaskState {
  final String message;

  const SearchTaskFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class SearchTaskEmpty extends SearchTaskState {}
