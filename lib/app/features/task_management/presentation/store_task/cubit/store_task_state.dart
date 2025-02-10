part of 'store_task_cubit.dart';

abstract class StoreTaskState extends Equatable {
  const StoreTaskState();

  @override
  List<Object> get props => [];
}

class StoreTaskInitial extends StoreTaskState {}

class StoreTaskLoading extends StoreTaskState {}

class StoreTaskSuccess extends StoreTaskState {
  const StoreTaskSuccess();

  @override
  List<Object> get props => [];
}

class StoreTaskFailure extends StoreTaskState {
  final String message;

  const StoreTaskFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
