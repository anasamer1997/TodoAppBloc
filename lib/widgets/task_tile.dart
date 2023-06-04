import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/bloc/bloc_export.dart';
import 'package:flutter_tasks_app/screens/edit_task_screen.dart';
import 'package:intl/intl.dart';
import '../models/taskModel.dart';
import 'popup_menu.dart';

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

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditTaskScreen(
            oldtask: task,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavourite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: task.isDone!
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      Text(DateFormat()
                          .add_yMEd()
                          .add_Hms()
                          .format(DateTime.parse(task.date))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                value: task.isDone,
                onChanged: task.isDeleted! == false
                    ? (value) {
                        context
                            .read<TaskBloc>()
                            .add(UpdateTaskEvent(task: task));
                      }
                    : null,
              ),
              PopUpMenu(
                  task: task,
                  cancelOrDeleteCallBack: () => _removeOrDelete(context, task),
                  likeOrUnlike: () => context.read<TaskBloc>().add(
                        MarkFavoriteOrUnfavoriteTask(task: task),
                      ),
                  editTaskCallBack: () {
                    Navigator.of(context).pop(context);
                    _editTask(context);
                  },
                  restoreTaskCallBack:() => context.read<TaskBloc>().add(TaskRestorEvent(task: task)) ,
                  )
            ],
          )
        ],
      ),
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
