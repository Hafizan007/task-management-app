import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/typograph.dart';
import '../cubit/list_task_cubit.dart';
import 'summary_item_widget.dart';

class SummaryTaskSection extends StatelessWidget {
  const SummaryTaskSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Summary',
              style: Typograph.subtitle20,
            ),
            const Icon(Icons.notifications_sharp),
          ],
        ),
        const SizedBox(height: 12),
        BlocBuilder<ListTaskCubit, ListTaskState>(builder: (context, state) {
          if (state is ListTaskLoading) {
            return const SizedBox();
          } else if (state is ListTaskFailure) {
            return const Center(
              child: Text('Failed to load summary'),
            );
          } else if (state is ListTaskSuccess) {
            return Row(
              children: [
                SummaryItemWidget(
                  title: 'Pending Task',
                  value: state.totalPendingTask.toString(),
                ),
                const SizedBox(width: 8),
                SummaryItemWidget(
                  title: 'Completed Task',
                  value: state.totalCompletedTask.toString(),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
      ],
    );
  }
}
