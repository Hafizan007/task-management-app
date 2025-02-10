import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/networking/network_info.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../datasources/profile_remote_datasource.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;
  final ProfileLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final profileData = await remoteDatasource.getProfileData();

        localDatasource.saveProfileData(profileData);

        return Right(profileData.toDomain());
      } catch (e) {
        return Left(ServerFailure(500, e.toString()));
      }
    } else {
      try {
        final profileData = await localDatasource.getProfileData();

        return Right(profileData.toDomain());
      } catch (e) {
        return Left(ServerFailure(500, e.toString()));
      }
    }
  }
}
