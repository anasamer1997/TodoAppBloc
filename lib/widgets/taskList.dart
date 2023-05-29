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
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: allTasks
              .map((task) => ExpansionPanelRadio(
                  value: task.id,
                  headerBuilder: (context, isExpanded) => TaskTile(task: task),
                  body: ListTile(
                    title: SelectableText.rich(TextSpan(children: [
                      const TextSpan(
                        text: 'Text\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: task.title),
                      const TextSpan(
                        text: '\n\nDescription\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: task.description),
                    ])),
                  )))
              .toList(),
        ),
      ),
    );
  }
}

/*
Expanded(
      child: ListView.builder(
        itemCount: allTasks.length,
        itemBuilder: (BuildContext context, int index) {
          var task = allTasks[index];
          return TaskTile(task: task);
        },
      ),
    );
    */