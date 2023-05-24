import 'package:flutter/material.dart';
import '../models/taskModel.dart';
import 'task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.allTasks,
  }) : super(key: key);

  final List<Task> allTasks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: allTasks.length,
        itemBuilder: (BuildContext context, int index) {
          var task = allTasks[index];
          return TaskTile(task: task);
        },
      ),
    );
  }
}
