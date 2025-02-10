import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/app_endpoint.dart';
import '../../../../config/networking/app_network.dart';
import '../models/profile_remote_model.dart';

abstract class ProfileRemoteDatasource {
  Future<ProfileRemoteModel> getProfileData();
}

@LazySingleton(as: ProfileRemoteDatasource)
class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final Dio dio;
  const ProfileRemoteDatasourceImpl({
    required this.dio,
  });

  @override
  Future<ProfileRemoteModel> getProfileData() async {
    Response response;

    response = await dio.get(
      "${AppNetwork().baseUrl}${AppEndPoint.login}",
    );

    return ProfileRemoteModel.fromJson(response.data);
  }
}
