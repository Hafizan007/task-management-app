import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injection/injection.dart';
import '../../../../../config/themes/app_color.dart';
import '../../../../../constants/typograph.dart';
import '../../../../../utils/widgets/textfield/main_textfield.dart';
import '../cubit/search_task_cubit.dart';
import '../widgets/task_item_widget.dart';

@RoutePage()
class SearchTaskPage extends StatefulWidget {
  const SearchTaskPage({super.key});

  @override
  State<SearchTaskPage> createState() => _SearchTaskPageState();
}

class _SearchTaskPageState extends State<SearchTaskPage> {
  final searchTaskCubit = getIt<SearchTaskCubit>();

  final searchController = TextEditingController();

  @override
  void initState() {
    searchTaskCubit.searchTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchTaskCubit,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('All Task'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MainTextfield(
                        controller: searchController,
                        labelText: 'Search Task',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          searchTaskCubit.searchTask(
                            searchQuery: searchController.text,
                          );
                        },
                        icon: const Icon(
                          Icons.search,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<SearchTaskCubit, SearchTaskState>(
                    builder: (context, state) {
                      if (state is SearchTaskLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchTaskFailure) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else if (state is SearchTaskSuccess) {
                        return Visibility(
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: double.maxFinite,
                              ),
                              Text('No Task Available',
                                  style: Typograph.headline5),
                            ],
                          ),
                          visible: state.taskList.isNotEmpty,
                          child: ListView.builder(
                            itemCount: state.taskList.length,
                            itemBuilder: (context, index) {
                              final itemData = state.taskList[index];

                              return TaskItemWidget(
                                title: itemData.title,
                                description: itemData.description,
                                dueDate: itemData.dueDate,
                                taskStatus: itemData.taskStatus,
                                onStatusChanged: (value) async {
                                  searchTaskCubit.updateStatusTask(
                                    taskId: itemData.id,
                                    taskStatus: value,
                                  );
                                },
                                onTaskDeleted: () {
                                  searchTaskCubit.deleteTask(itemData.id);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
