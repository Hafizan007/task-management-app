import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

@lazySingleton
class GetProfileUsecase extends UseCase<ProfileEntity, NoParams> {
  final ProfileRepository profileRepository;

  GetProfileUsecase({required this.profileRepository});

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) async {
    return await profileRepository.getProfile();
  }
}
