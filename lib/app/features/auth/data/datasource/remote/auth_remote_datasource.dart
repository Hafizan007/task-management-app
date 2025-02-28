import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/networking/app_endpoint.dart';
import '../../../../../config/networking/app_exception.dart';
import '../../../../../config/networking/app_network.dart';
import '../../../../../constants/error_constant.dart';
import '../../model/login_remote_model.dart';
import '../../model/login_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginRemoteModel> loginByEmail(
      {required LoginRequestModel loginRequest});
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  const AuthRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<LoginRemoteModel> loginByEmail(
      {required LoginRequestModel loginRequest}) async {
    try {
      final response = await dio.post(
        "${AppNetwork().baseUrl}${AppEndPoint.login}",
        data: loginRequest.toJson(),
      );
      return LoginRemoteModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final message = e.response?.data['error'] ?? ErrorConstant.unauthorized;
        throw ServerException(
          message: message,
          statusCode: e.response?.statusCode,
        );
      } else {
        throw ServerException(
          message: e.message ?? ErrorConstant.unauthorized,
          statusCode: e.response?.statusCode,
          stackTrace: e.stackTrace,
        );
      }
    }
  }
}
