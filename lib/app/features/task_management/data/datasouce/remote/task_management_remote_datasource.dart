import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/networking/app_endpoint.dart';
import '../../../../../config/networking/app_exception.dart';
import '../../../../../config/networking/app_network.dart';
import '../../../../../constants/error_constant.dart';
import '../../models/task_model.dart';
import '../../models/task_store_request_model.dart';
import '../../models/task_update_request_model.dart';

abstract class TaskManagementRemoteDataSource {
  Future<TaskModel> getTaskManagementData();
  Future<void> storeTaskData(TaskStoreRequestModel taskModel);
  Future<void> updateTaskData(TaskUpdateRequestModel taskModel);
}

@LazySingleton(as: TaskManagementRemoteDataSource)
class TaskManagementRemoteDataSourceImpl
    implements TaskManagementRemoteDataSource {
  final Dio dio;

  TaskManagementRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<TaskModel> getTaskManagementData() async {
    try {
      final response = await dio.post(
        "${AppNetwork().baseUrl}${AppEndPoint.task}",
      );
      return TaskModel.fromJson(response.data);
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

  @override
  Future<void> storeTaskData(TaskStoreRequestModel taskModel) async {
    try {
      await dio.post(
        "${AppNetwork().baseUrl}${AppEndPoint.task}",
        data: taskModel.toJson(),
      );
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

  @override
  Future<void> updateTaskData(TaskUpdateRequestModel taskModel) async {
    try {
      await dio.put(
        "${AppNetwork().baseUrl}${AppEndPoint.task}",
        data: taskModel.toJson(),
      );
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
