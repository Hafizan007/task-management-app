import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection/injection.dart';
import '../../../../config/router/app_router.gr.dart';
import '../../../auth/presentation/logout/cubit/logout_cubit.dart';
import '../../../task_management/presentation/list_task/cubit/list_task_cubit.dart';
import '../../../task_management/presentation/list_task/widgets/list_task_section.dart';
import '../../../task_management/presentation/list_task/widgets/summary_task_section.dart';
import '../widgets/home_appbar.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final listTaskCubit = getIt<ListTaskCubit>();
  final logoutCubit = getIt<LogoutCubit>();

  @override
  void initState() {
    listTaskCubit.getListTask();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: listTaskCubit),
        BlocProvider.value(value: logoutCubit),
      ],
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            context.router.replace(const LoginRoute());
          } else if (state is LogoutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: const HomeAppbar(),
          body: const SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SummaryTaskSection(),
                ListTaskSection(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: onTapAddTask,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void onTapAddTask() async {
    final didStore = await context.pushRoute(const StoreTaskRoute());

    if (didStore == true) {
      listTaskCubit.getListTask();
    }
  }
}
