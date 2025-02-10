import 'package:management_app/app/config/networking/network_info.dart';
import 'package:management_app/app/features/auth/data/datasource/local/auth_local_datasource.dart';
import 'package:management_app/app/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:management_app/app/features/auth/domain/repositories/auth_repositoriy.dart';
import 'package:management_app/app/features/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:management_app/app/features/task_management/data/datasouce/local/task_management_local_datasource.dart';
import 'package:management_app/app/features/task_management/data/datasouce/remote/task_management_remote_datasource.dart';
import 'package:management_app/app/features/task_management/domain/repositories/task_management_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  /// AUTH RELATED
  AuthLocalDataSource,
  AuthRemoteDataSource,
  NetworkInfo,
  AuthRepository,
  LoginWithEmailUseCase,

  /// TASK MANAGEMENT RELATED
  TaskManagementLocalDataSource,
  TaskManagementRemoteDataSource,
  TaskManagementRepository,
])
void main() {}
