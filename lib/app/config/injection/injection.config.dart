// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:management_app/app/config/data/datasources/local/database_helper.dart'
    as _i26;
import 'package:management_app/app/config/injection/app_module.dart' as _i405;
import 'package:management_app/app/config/networking/api_client.dart' as _i660;
import 'package:management_app/app/config/networking/network_info.dart'
    as _i541;
import 'package:management_app/app/config/services/sync_service.dart' as _i714;
import 'package:management_app/app/features/auth/data/datasource/local/auth_local_datasource.dart'
    as _i385;
import 'package:management_app/app/features/auth/data/datasource/remote/auth_remote_datasource.dart'
    as _i269;
import 'package:management_app/app/features/auth/data/repositories/auth_repository_impl.dart'
    as _i119;
import 'package:management_app/app/features/auth/domain/repositories/auth_repositoriy.dart'
    as _i314;
import 'package:management_app/app/features/auth/domain/usecases/check_auth_status_usecase.dart'
    as _i71;
import 'package:management_app/app/features/auth/domain/usecases/login_with_email_usecase.dart'
    as _i638;
import 'package:management_app/app/features/auth/domain/usecases/logout_usecase.dart'
    as _i437;
import 'package:management_app/app/features/auth/presentation/login/cubits/login_cubit.dart'
    as _i984;
import 'package:management_app/app/features/auth/presentation/logout/cubit/logout_cubit.dart'
    as _i57;
import 'package:management_app/app/features/profile/data/datasources/profile_local_datasource.dart'
    as _i740;
import 'package:management_app/app/features/profile/data/datasources/profile_remote_datasource.dart'
    as _i199;
import 'package:management_app/app/features/profile/data/repositories/profile_repository_impl.dart'
    as _i262;
import 'package:management_app/app/features/profile/domain/repositories/profile_repository.dart'
    as _i211;
import 'package:management_app/app/features/profile/domain/usecases/get_profile_usecase.dart'
    as _i603;
import 'package:management_app/app/features/profile/presentation/profile/logics/profile_cubit.dart'
    as _i31;
import 'package:management_app/app/features/splash/presentation/cubit/splash_cubit.dart'
    as _i433;
import 'package:management_app/app/features/task_management/data/datasouce/local/task_management_local_datasource.dart'
    as _i346;
import 'package:management_app/app/features/task_management/data/datasouce/remote/task_management_remote_datasource.dart'
    as _i1055;
import 'package:management_app/app/features/task_management/data/repositories/task_management_repository_impl.dart'
    as _i1019;
import 'package:management_app/app/features/task_management/domain/repositories/task_management_repository.dart'
    as _i348;
import 'package:management_app/app/features/task_management/domain/usecases/delete_task_usecase.dart'
    as _i981;
import 'package:management_app/app/features/task_management/domain/usecases/list_task_usecase.dart'
    as _i64;
import 'package:management_app/app/features/task_management/domain/usecases/store_task_usecase.dart'
    as _i667;
import 'package:management_app/app/features/task_management/domain/usecases/update_task_usecase.dart'
    as _i684;
import 'package:management_app/app/features/task_management/presentation/list_task/cubit/list_task_cubit.dart'
    as _i378;
import 'package:management_app/app/features/task_management/presentation/list_task/cubit/search_task_cubit.dart'
    as _i754;
import 'package:management_app/app/features/task_management/presentation/store_task/cubit/store_task_cubit.dart'
    as _i246;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    final appModule = _$AppModule();
    gh.singleton<_i361.Dio>(() => dioModule.instance);
    gh.singleton<_i895.Connectivity>(() => appModule.connectivity);
    gh.singleton<_i26.DatabaseHelper>(() => _i26.DatabaseHelper());
    gh.lazySingleton<_i541.NetworkInfo>(
        () => _i541.NetworkInfoImpl(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i385.AuthLocalDataSource>(
        () => _i385.AuthLocalDataSourceImpl());
    gh.lazySingleton<_i740.ProfileLocalDatasource>(
        () => _i740.ProfileLocalDatasourceImpl());
    gh.lazySingleton<_i269.AuthRemoteDataSource>(
        () => _i269.AuthRemoteDataSourceImpl(dio: gh<_i361.Dio>()));
    gh.lazySingleton<_i1055.TaskManagementRemoteDataSource>(
        () => _i1055.TaskManagementRemoteDataSourceImpl(dio: gh<_i361.Dio>()));
    gh.lazySingleton<_i199.ProfileRemoteDatasource>(
        () => _i199.ProfileRemoteDatasourceImpl(dio: gh<_i361.Dio>()));
    gh.lazySingleton<_i346.TaskManagementLocalDataSource>(() =>
        _i346.TaskManagementLocalDataSourceImpl(
            databaseHelper: gh<_i26.DatabaseHelper>()));
    gh.lazySingleton<_i314.AuthRepository>(() => _i119.AuthRepositoryImpl(
          remoteDataSource: gh<_i269.AuthRemoteDataSource>(),
          localDataSource: gh<_i385.AuthLocalDataSource>(),
          networkInfo: gh<_i541.NetworkInfo>(),
        ));
    gh.lazySingleton<_i211.ProfileRepository>(() => _i262.ProfileRepositoryImpl(
          remoteDatasource: gh<_i199.ProfileRemoteDatasource>(),
          localDatasource: gh<_i740.ProfileLocalDatasource>(),
          networkInfo: gh<_i541.NetworkInfo>(),
        ));
    gh.lazySingleton<_i348.TaskManagementRepository>(
        () => _i1019.TaskManagementRepositoryImpl(
              localDataSource: gh<_i346.TaskManagementLocalDataSource>(),
              networkInfo: gh<_i541.NetworkInfo>(),
              remoteDatasource: gh<_i1055.TaskManagementRemoteDataSource>(),
            ));
    gh.lazySingleton<_i437.LogoutUsecase>(
        () => _i437.LogoutUsecase(gh<_i314.AuthRepository>()));
    gh.lazySingleton<_i638.LoginWithEmailUseCase>(
        () => _i638.LoginWithEmailUseCase(gh<_i314.AuthRepository>()));
    gh.lazySingleton<_i603.GetProfileUsecase>(() => _i603.GetProfileUsecase(
        profileRepository: gh<_i211.ProfileRepository>()));
    gh.lazySingleton<_i71.CheckAuthStatusUsecase>(() =>
        _i71.CheckAuthStatusUsecase(repository: gh<_i314.AuthRepository>()));
    gh.lazySingleton<_i684.UpdateTaskUsecase>(() => _i684.UpdateTaskUsecase(
        repository: gh<_i348.TaskManagementRepository>()));
    gh.lazySingleton<_i981.DeleteTaskUsecase>(() => _i981.DeleteTaskUsecase(
        repository: gh<_i348.TaskManagementRepository>()));
    gh.lazySingleton<_i64.ListTaskUsecase>(() =>
        _i64.ListTaskUsecase(repository: gh<_i348.TaskManagementRepository>()));
    gh.lazySingleton<_i667.StoreTaskUsecase>(() => _i667.StoreTaskUsecase(
        repository: gh<_i348.TaskManagementRepository>()));
    gh.factory<_i984.LoginCubit>(
        () => _i984.LoginCubit(gh<_i638.LoginWithEmailUseCase>()));
    gh.singleton<_i714.SyncService>(
        () => _i714.SyncService(gh<_i348.TaskManagementRepository>()));
    gh.factory<_i433.SplashCubit>(() => _i433.SplashCubit(
        checkAuthStatusUsecase: gh<_i71.CheckAuthStatusUsecase>()));
    gh.factory<_i57.LogoutCubit>(
        () => _i57.LogoutCubit(gh<_i437.LogoutUsecase>()));
    gh.factory<_i246.StoreTaskCubit>(() =>
        _i246.StoreTaskCubit(storeTaskUsecase: gh<_i667.StoreTaskUsecase>()));
    gh.factory<_i31.ProfileCubit>(
        () => _i31.ProfileCubit(usecase: gh<_i603.GetProfileUsecase>()));
    gh.factory<_i378.ListTaskCubit>(() => _i378.ListTaskCubit(
          listTaskUsecase: gh<_i64.ListTaskUsecase>(),
          updateTaskUsecase: gh<_i684.UpdateTaskUsecase>(),
          deleteTaskUsecase: gh<_i981.DeleteTaskUsecase>(),
        ));
    gh.factory<_i754.SearchTaskCubit>(() => _i754.SearchTaskCubit(
          listTaskUsecase: gh<_i64.ListTaskUsecase>(),
          updateTaskUsecase: gh<_i684.UpdateTaskUsecase>(),
          deleteTaskUsecase: gh<_i981.DeleteTaskUsecase>(),
        ));
    return this;
  }
}

class _$DioModule extends _i660.DioModule {}

class _$AppModule extends _i405.AppModule {}
