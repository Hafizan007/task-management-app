// test/features/auth/presentation/login/cubits/login_cubit_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:management_app/app/features/auth/domain/entities/login_entity.dart';
import 'package:management_app/app/features/auth/presentation/login/cubits/login_cubit.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mock_container.mocks.dart';

void main() {
  late LoginCubit loginCubit;
  late MockLoginWithEmailUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginWithEmailUseCase();
    loginCubit = LoginCubit(mockLoginUseCase);
  });

  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LoginSuccess] when login is successful',
    build: () {
      when(mockLoginUseCase(any))
          .thenAnswer((_) async => const Right(LoginEntity(token: 'token')));
      return loginCubit;
    },
    act: (cubit) => cubit.login(
      'test@test.com',
      '123456',
    ),
    expect: () => [
      isA<LoginLoading>(),
      isA<LoginSuccess>(),
    ],
  );
}
