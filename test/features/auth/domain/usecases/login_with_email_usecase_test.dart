// test/features/auth/domain/usecases/login_with_email_usecase_test.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:management_app/app/features/auth/domain/entities/login_entity.dart';
import 'package:management_app/app/features/auth/domain/params/login_by_email_params.dart';
import 'package:management_app/app/features/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mock_container.mocks.dart';

void main() {
  late LoginWithEmailUseCase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = LoginWithEmailUseCase(mockRepository);
  });

  test('should get LoginEntity from repository', () async {
    // arrange
    const params = LoginByEmailParams(
      email: 'test@test.com',
      password: '123456',
    );
    const loginEntity = LoginEntity(token: 'token');
    when(mockRepository.loginByEmail(any)).thenAnswer(
      (_) async => const Right(loginEntity),
    );

    // act
    final result = await usecase(params);

    // assert
    expect(result, const Right(loginEntity));
    verify(mockRepository.loginByEmail(params));
    verifyNoMoreInteractions(mockRepository);
  });
}
