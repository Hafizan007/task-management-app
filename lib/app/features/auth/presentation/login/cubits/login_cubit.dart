import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/login_entity.dart';
import '../../../domain/params/login_by_email_params.dart';
import '../../../domain/usecases/login_with_email_usecase.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginWithEmailUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());

    final result = await loginUseCase(
      LoginByEmailParams(email: email, password: password),
    );
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }
}
