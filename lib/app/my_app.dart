import 'package:flutter/material.dart';

import 'config/router/router.dart';
import 'config/themes/app_theme.dart';
import 'constants/app_constant.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstant.appName,
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.delegate(),
      locale: const Locale('en'),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
