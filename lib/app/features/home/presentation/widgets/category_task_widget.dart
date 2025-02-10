import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_color.dart';
import '../../../../constants/typograph.dart';
import '../../../task_management/domain/entities/task_entity.dart';
import '../../../task_management/presentation/list_task/cubit/list_task_cubit.dart';

class CategoryTaskWidget extends StatefulWidget {
  const CategoryTaskWidget({super.key});

  @override
  State<CategoryTaskWidget> createState() => _CategoryTaskWidgetState();
}

class _CategoryTaskWidgetState extends State<CategoryTaskWidget>
    with SingleTickerProviderStateMixin {
  TaskStatus selectedSegment = TaskStatus.pending;
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateSelectedIndex(TaskStatus value) {
    switch (value) {
      case TaskStatus.pending:
        _selectedIndex = 0;
        break;
      case TaskStatus.inProgress:
        _selectedIndex = 1;
        break;
      case TaskStatus.completed:
        _selectedIndex = 2;
        break;
    }
    final newTween = Tween<double>(
      begin: _animation.value,
      end: _selectedIndex,
    );
    setState(() {
      _animation = newTween.animate(_animationController);
    });
    _animationController
      ..reset()
      ..forward();

    setState(() {
      selectedSegment = value;
    });
    HapticFeedback.lightImpact();
    context.read<ListTaskCubit>().filterByStatus(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColor.whiteColor,
        border: Border.all(color: AppColor.greyColor),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / 3;

          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(segmentWidth * _animation.value, 0),
                    child: SizedBox(
                      width: segmentWidth,
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Row(
                children: List.generate(
                  TaskStatus.values.length,
                  (index) {
                    final value = TaskStatus.values[index];
                    return _buildSegment(value);
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildSegment(TaskStatus value) {
    final isSelected = selectedSegment == value;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () => _updateSelectedIndex(value),
          child: Container(
            height: 36,
            alignment: Alignment.center,
            child: Text(
              buildSegment(value),
              style: Typograph.subtitle14m.copyWith(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color:
                    isSelected ? AppColor.whiteColor : AppColor.greyTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String buildSegment(TaskStatus value) {
    switch (value) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In progress';
      case TaskStatus.completed:
        return 'Completed';
    }
  }
}
