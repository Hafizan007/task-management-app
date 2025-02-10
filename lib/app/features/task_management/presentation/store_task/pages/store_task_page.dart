import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injection/injection.dart';
import '../../../../../config/themes/app_color.dart';
import '../../../../../utils/widgets/appbar/main_appbar.dart';
import '../cubit/store_task_cubit.dart';
import '../widgets/store_task_form.dart';

@RoutePage()
class StoreTaskPage extends StatefulWidget {
  const StoreTaskPage({super.key});

  @override
  State<StoreTaskPage> createState() => _StoreTaskPageState();
}

class _StoreTaskPageState extends State<StoreTaskPage> {
  final storeTaskCubit = getIt<StoreTaskCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => storeTaskCubit,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const CustomAppBar(
            title: 'Create new task',
          ),
          body: BlocListener<StoreTaskCubit, StoreTaskState>(
            listener: (context, state) {
              if (state is StoreTaskSuccess) {
                context.maybePop(true);
              } else if (state is StoreTaskFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColor.greyTextColor,
                  ),
                );
              }
            },
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 24),
                    decoration: const BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: const StoreTaskForm(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
