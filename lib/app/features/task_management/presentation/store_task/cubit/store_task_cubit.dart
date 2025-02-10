import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/notification/notification_service.dart';
import '../../../domain/params/store_task_params.dart';
import '../../../domain/usecases/store_task_usecase.dart';

part 'store_task_state.dart';

@injectable
class StoreTaskCubit extends Cubit<StoreTaskState> {
  final StoreTaskUsecase storeTaskUsecase;
  final NotificationService notificationService;

  StoreTaskCubit({
    required this.storeTaskUsecase,
    required this.notificationService,
  }) : super(StoreTaskInitial());

  Future<void> storeTask(StoreTaskParams params) async {
    emit(StoreTaskLoading());

    final result = await storeTaskUsecase(params);

    result.fold(
      (failure) => emit(StoreTaskFailure(message: failure.message)),
      (data) {
        notificationService.setNotification(
          body: data.title,
          date: data.dueDate,
          taskId: data.id,
        );
        emit(const StoreTaskSuccess());
      },
    );
  }
}
