import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:management_app/app/features/auth/data/model/login_remote_model.dart';
import 'package:management_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:management_app/app/features/auth/domain/params/login_by_email_params.dart';
import 'package:management_app/app/features/auth/domain/repositories/auth_repositoriy.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mock_container.mocks.dart';

void main() {
  late AuthRepository repository;
  late MockAuthLocalDataSource mockLocalDataSource;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockAuthLocalDataSource();
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AuthRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('loginByEmail', () {
    const params = LoginByEmailParams(
      email: 'test@test.com',
      password: '123456',
    );

    final loginModel = LoginRemoteModel(token: 'token');

    test('should return LoginEntity when login is successful', () async {
      when(mockRemoteDataSource.loginByEmail(
        loginRequest: anyNamed('loginRequest'),
      )).thenAnswer((_) async => loginModel);
      when(mockLocalDataSource.storeUserData(any)).thenAnswer((_) async => {});

      final result = await repository.loginByEmail(params);

      expect(result, Right(loginModel.toDomain()));

      verify(mockRemoteDataSource.loginByEmail(
        loginRequest: anyNamed('loginRequest'),
      ));
      verify(mockLocalDataSource.storeUserData(any));
    });
  });
}
