// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:management_app/app/features/auth/presentation/login/pages/login_page.dart'
    as _i2;
import 'package:management_app/app/features/home/presentation/pages/home_page.dart'
    as _i1;
import 'package:management_app/app/features/splash/presentation/pages/splash_screen.dart'
    as _i4;
import 'package:management_app/app/features/task_management/presentation/list_task/pages/search_task_page.dart'
    as _i3;
import 'package:management_app/app/features/task_management/presentation/store_task/pages/store_task_page.dart'
    as _i5;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    SearchTaskRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SearchTaskPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SplashPage(),
      );
    },
    StoreTaskRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.StoreTaskPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SearchTaskPage]
class SearchTaskRoute extends _i6.PageRouteInfo<void> {
  const SearchTaskRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SearchTaskRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchTaskRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SplashPage]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.StoreTaskPage]
class StoreTaskRoute extends _i6.PageRouteInfo<void> {
  const StoreTaskRoute({List<_i6.PageRouteInfo>? children})
      : super(
          StoreTaskRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoreTaskRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
