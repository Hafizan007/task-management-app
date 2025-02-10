import 'package:dartz/dartz.dart';

import '../../../../config/networking/failure.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
}
