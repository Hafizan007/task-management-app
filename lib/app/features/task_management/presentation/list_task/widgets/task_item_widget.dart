import 'package:flutter/material.dart';

import '../../../../../config/themes/app_color.dart';
import '../../../../../constants/typograph.dart';
import '../../../../../utils/helpers/date_helper.dart';
import '../../../domain/entities/task_entity.dart';

class TaskItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskStatus taskStatus;
  final ValueChanged<TaskStatus>? onStatusChanged;
  final Function()? onTaskDeleted;
  const TaskItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.taskStatus,
    this.onStatusChanged,
    this.onTaskDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.greyColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Typograph.subtitle16m,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onSelected: (value) {
                  if (onStatusChanged == null) return;
                  if (value == 'inProgress') {
                    onStatusChanged!(TaskStatus.inProgress);
                  } else if (value == 'completed') {
                    onStatusChanged!(TaskStatus.completed);
                  } else if (value == 'remove') {
                    onTaskDeleted!();
                  }
                },
                itemBuilder: (context) => [
                  if (taskStatus == TaskStatus.pending)
                    const PopupMenuItem(
                      value: 'inProgress',
                      child: Text('Move to In Progress'),
                    ),
                  if (taskStatus == TaskStatus.inProgress)
                    const PopupMenuItem(
                      value: 'completed',
                      child: Text('Move to Completed'),
                    ),
                  const PopupMenuItem(
                    value: 'remove',
                    child: Text('Delete Task'),
                  ),
                ],
                child:
                    const Icon(Icons.more_vert, color: AppColor.greyTextColor),
              ),
            ],
          ),
          Text(description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Typograph.body12r.copyWith(
                color: AppColor.greyTextColor,
              )),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 12,
                    color: AppColor.greyTextColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateHelper.dateTimeToStrDate2(dueDate),
                    style: Typograph.body12r.copyWith(
                      color: AppColor.greyTextColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: getStatusColor(taskStatus),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  taskStatusToString(taskStatus),
                  style: Typograph.button12m.copyWith(
                    color: getStatusTextColor(taskStatus),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Color getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.inProgress:
        return AppColor.blueOverlayColor;
      case TaskStatus.completed:
        return AppColor.secondaryColor;
      case TaskStatus.pending:
        return AppColor.greyColor;
      default:
        return Colors.grey;
    }
  }

  static Color getStatusTextColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.inProgress:
        return AppColor.blueColor;
      case TaskStatus.completed:
        return AppColor.primaryColor;
      case TaskStatus.pending:
        return AppColor.greyTextColor;
      default:
        return AppColor.whiteColor;
    }
  }

  static String taskStatusToString(TaskStatus status) {
    switch (status) {
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.pending:
        return 'Pending';
      default:
        return 'Unknown';
    }
  }
}
