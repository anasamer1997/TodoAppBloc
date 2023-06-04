import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/taskModel.dart';

class PopUpMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallBack;
  final VoidCallback likeOrUnlike;
  final VoidCallback editTaskCallBack;
  final VoidCallback restoreTaskCallBack;
  const PopUpMenu({
    Key? key,
     required this.task,
    required this.cancelOrDeleteCallBack,
    required this.likeOrUnlike, 
    required this.editTaskCallBack,
     required this.restoreTaskCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: task.isDeleted == false
            ? (context) => [
                  PopupMenuItem(
                    onTap: likeOrUnlike,
                    child: TextButton.icon(
                      onPressed: null,
                      icon: task.isFavourite == false
                          ? const Icon(Icons.bookmark_add_outlined)
                          : const Icon(Icons.bookmark_remove),
                      label: task.isFavourite == false
                          ? const Text('Add to\nBookMarks')
                          : const Text('Remove from\nBookMarks'),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: null,
                    child: TextButton.icon(
                      onPressed: editTaskCallBack,
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: cancelOrDeleteCallBack,
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                    ),
                  ),
                ]
            : (context) => [
                  PopupMenuItem(
                    onTap: restoreTaskCallBack,
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.restore),
                      label: const Text('Restore'),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: cancelOrDeleteCallBack,
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                    ),
                  ),
                ]);
  }
}
