import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/bloc/bloc_export.dart';

import '../widgets/taskList.dart';
import 'myDrawer.dart';
// import 'package:test_api/expect.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);
  static const id = 'RecycleBin';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          drawer: const MyDrawer(),
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              )
            ],
          ),
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Center(
              child: Chip(
                label: Text('${state.removedtasks.length} tasks'),
              ),
            ),
            TaskList(allTasks: state.removedtasks),
          ]),
        );
      },
    );
  }
}
