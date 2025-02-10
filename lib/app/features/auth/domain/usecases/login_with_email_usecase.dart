import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../entities/login_entity.dart';
import '../params/login_by_email_params.dart';
import '../repositories/auth_repositoriy.dart';

@lazySingleton
class LoginWithEmailUseCase
    implements UseCase<LoginEntity, LoginByEmailParams> {
  final AuthRepository repository;

  LoginWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginByEmailParams params) {
    return repository.loginByEmail(params);
  }
}
