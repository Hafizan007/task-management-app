import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/params/store_task_params.dart';
import '../../../domain/usecases/store_task_usecase.dart';

part 'store_task_state.dart';

@injectable
class StoreTaskCubit extends Cubit<StoreTaskState> {
  final StoreTaskUsecase storeTaskUsecase;

  StoreTaskCubit({
    required this.storeTaskUsecase,
  }) : super(StoreTaskInitial());

  Future<void> storeTask(StoreTaskParams params) async {
    emit(StoreTaskLoading());

    final result = await storeTaskUsecase(params);

    result.fold(
      (failure) => emit(StoreTaskFailure(message: failure.message)),
      (_) => emit(const StoreTaskSuccess()),
    );
  }
}
