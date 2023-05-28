import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/bloc/bloc_export.dart';
import '../widgets/taskList.dart';

class FavoritTasksScreen extends StatelessWidget {
  const FavoritTasksScreen({Key? key}) : super(key: key);
  static const id = 'TasksScreen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  '${state.pendingTasks.length} Tasks',
                ),
              ),
            ),
            TaskList(allTasks: state.pendingTasks),
          ],
        );
      },
    );
  }
}
