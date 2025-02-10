import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/notification/notification_service.dart';
import '../../../../config/usecase/usecase.dart';
import '../../../auth/domain/usecases/check_auth_status_usecase.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final CheckAuthStatusUsecase checkAuthStatusUsecase;
  final NotificationService notificationService;

  SplashCubit({
    required this.checkAuthStatusUsecase,
    required this.notificationService,
  }) : super(SplashInitial());

  Future<void> checkAuthentification() async {
    emit(SplashLoading());

    notificationService.reqPermission();

    final result = await checkAuthStatusUsecase(NoParams());
    result.fold(
      (failure) => emit(SplashError(failure.message)),
      (isAuthenticated) {
        if (isAuthenticated) {
          emit(SplashAuthenticated());
        } else {
          emit(SplashUnauthenticated());
        }
      },
    );
  }
}
