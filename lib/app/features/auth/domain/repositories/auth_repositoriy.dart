import 'package:dartz/dartz.dart';

import '../../../../config/networking/failure.dart';
import '../entities/login_entity.dart';
import '../params/login_by_email_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> loginByEmail(LoginByEmailParams params);
  Future<Either<Failure, bool>> checkAuthStatus();
  Future<Either<Failure, void>> logout();
}
