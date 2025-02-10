import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router.gr.dart';
import '../../../../../constants/typograph.dart';
import '../../../../home/presentation/widgets/category_task_widget.dart';
import '../cubit/list_task_cubit.dart';
import 'task_item_widget.dart';

class ListTaskSection extends StatefulWidget {
  const ListTaskSection({super.key});

  @override
  State<ListTaskSection> createState() => _ListTaskSectionState();
}

class _ListTaskSectionState extends State<ListTaskSection> {
  @override
  Widget build(BuildContext context) {
    final listTaskCubit = context.read<ListTaskCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              'My Task',
              style: Typograph.subtitle20,
            ),
            const Spacer(),
            InkWell(
              onTap: () => context.pushRoute(const SearchTaskRoute()),
              child: Text(
                'View All',
                style: Typograph.label14m,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const CategoryTaskWidget(),
        const SizedBox(height: 12),
        BlocBuilder<ListTaskCubit, ListTaskState>(
          builder: (context, state) {
            if (state is ListTaskLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ListTaskFailure) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is ListTaskSuccess) {
              return Visibility(
                replacement: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: double.maxFinite,
                    ),
                    Text('No Task Available', style: Typograph.headline5),
                  ],
                ),
                visible: state.taskList.isNotEmpty,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.taskList.length,
                  itemBuilder: (context, index) {
                    final itemData = state.taskList[index];

                    return TaskItemWidget(
                      title: itemData.title,
                      description: itemData.description,
                      dueDate: itemData.dueDate,
                      taskStatus: itemData.taskStatus,
                      onStatusChanged: (value) async {
                        listTaskCubit.updateStatusTask(
                          taskId: itemData.id,
                          taskStatus: value,
                        );
                      },
                      onTaskDeleted: () {
                        listTaskCubit.deleteTask(itemData.id);
                      },
                    );
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
