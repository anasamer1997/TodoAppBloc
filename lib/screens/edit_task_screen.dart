import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/bloc/bloc_export.dart';
import 'package:flutter_tasks_app/models/taskModel.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldtask;
  const EditTaskScreen({
    Key? key,
    required this.oldtask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController =
        TextEditingController(text: oldtask.title);
    TextEditingController descriptionEditingController =
        TextEditingController(text: oldtask.description);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Edit Task",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: textEditingController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            autofocus: true,
            controller: descriptionEditingController,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    if (textEditingController.text != "") {
                      var editTask = Task(
                          id: oldtask.id,
                          isDone: false,
                          isFavourite: oldtask.isFavourite,
                          title: textEditingController.text,
                          description: descriptionEditingController.text,
                          date: DateTime.now().toString());
                      context
                          .read<TaskBloc>()
                          .add(EditTaskEvent( oldTask:oldtask, newTask: editTask));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("save")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("cancel")),
            ],
          )
        ],
      ),
    );
  }
}
