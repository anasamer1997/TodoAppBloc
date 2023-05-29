import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/bloc/bloc_export.dart';
import 'package:flutter_tasks_app/models/taskModel.dart';
import 'package:flutter_tasks_app/service/service.dart';

class AddTask extends StatefulWidget {
  const AddTask({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Add Task",
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
                      var task = Task(
                          id: GUIDGen.generate(),
                          title: textEditingController.text,
                          description: descriptionEditingController.text);
                      context.read<TaskBloc>().add(AddTaskEvent(task: task));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("delete")),
            ],
          )
        ],
      ),
    );
  }
}
