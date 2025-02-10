import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/typograph.dart';
import '../../../../../utils/helpers/validator_form.dart';
import '../../../../../utils/widgets/button/custom_fill_button.dart';
import '../../../../../utils/widgets/textfield/big_textfield.dart';
import '../../../../../utils/widgets/textfield/main_textfield.dart';
import '../../../domain/params/store_task_params.dart';
import '../cubit/store_task_cubit.dart';

class StoreTaskForm extends StatefulWidget {
  const StoreTaskForm({super.key});

  @override
  State<StoreTaskForm> createState() => _StoreTaskFormState();
}

class _StoreTaskFormState extends State<StoreTaskForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final deadlineController = TextEditingController();

  DateTime deadlineDate = DateTime.now();
  final unfocusNode = FocusNode();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigTextfield(
            controller: titleController,
            labelText: 'Title Task',
            maxLength: 50,
            validator: ValidatorForm.validatedRequired,
          ),
          const SizedBox(height: 16),
          Text(
            'Task Description',
            style: Typograph.label14m,
          ),
          const SizedBox(height: 10),
          MainTextfield(
            focusNode: unfocusNode,
            controller: descriptionController,
            labelText: 'Description',
            minLines: 3,
            maxLines: 5,
          ),
          const SizedBox(height: 12),
          Text(
            'Deadline',
            style: Typograph.label14m,
          ),
          const SizedBox(height: 10),
          MainTextfield(
            readOnly: true,
            controller: deadlineController,
            labelText: 'DD/MM/YYYY',
            validator: ValidatorForm.validatedRequired,
            onTap: () {
              _selectDateAndTime(context);
              FocusScope.of(context).nextFocus();
            },
          ),
          const Spacer(),
          BlocBuilder<StoreTaskCubit, StoreTaskState>(
              builder: (context, state) {
            return CustomFillButton(
              text: 'Create Task',
              isLoading: state is StoreTaskLoading,
              onPressed: onTapStoreTask,
            );
          }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ],
      ),
    );
  }

  void onTapStoreTask() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<StoreTaskCubit>().storeTask(StoreTaskParams(
            title: titleController.text,
            description: descriptionController.text,
            dueDate: deadlineDate,
          ));
    }
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      if (mounted) {
        deadlineDate = pickedDate;
      }
      final TimeOfDay? pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (!_isValidTime(pickedTime, pickedDate)) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a time at least 2 minutes from now'),
            ),
          );
          return;
        }
        deadlineDate = combinedDateTime;

        deadlineController.text =
            "${combinedDateTime.day}-${combinedDateTime.month}-${combinedDateTime.year} "
            // ignore: use_build_context_synchronously
            "${pickedTime.format(context)}";
      }
    }
  }

  bool _isValidTime(TimeOfDay time, DateTime selectedDate) {
    final now = DateTime.now();
    final selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      time.hour,
      time.minute,
    );

    final minimumTime = now.add(const Duration(minutes: 2));
    return selectedDateTime.isAfter(minimumTime);
  }
}
