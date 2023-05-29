import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/bloc/bloc_export.dart';
import '../models/taskModel.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDelete(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TaskBloc>().add(DeleteTaskEvent(task: task))
        : ctx.read<TaskBloc>().add(RemoveTaskEvent(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star_outline),
        Text(
          task.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            decoration:
                task.isDone! ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
      ],
    );
  }
}

/*ListTile(
      title: Text(
        task.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          decoration:
              task.isDone! ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Checkbox(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        value: task.isDone,
        onChanged: task.isDeleted! == false
            ? (value) {
                context.read<TaskBloc>().add(UpdateTaskEvent(task: task));
              }
            : null,
      ),
      onLongPress: () => _removeOrDelete(context, task),
    );*/
