// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> taskList;
  final List<Task> removedtasks;
  const TaskState({
    this.removedtasks = const <Task>[],
    this.taskList = const <Task>[],
  });

  @override
  List<Object> get props => [taskList, removedtasks];

  TaskState copyWith({
    List<Task>? taskList,
    List<Task>? removedtasks,
  }) {
    return TaskState(
      taskList: taskList ?? this.taskList,
      removedtasks: removedtasks ?? this.removedtasks,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'taskList': taskList.map((x) => x.toMap()).toList(),
  //     'removedtasks': taskList.map((x) => x.toMap()).toList(),
  //   };
  // }

  // factory TaskState.fromMap(Map<String, dynamic> map) {
  //   return TaskState(
  //       taskList: List<Task>.from(
  //         (map['taskList'] as List<int>).map<Task>(
  //           (x) => Task.fromMap(x as Map<String, dynamic>),
  //         ),
  //       ),
  //       removedtasks: List<Task>.from(
  //         (map['removedtasks'] as List<int>).map<Task>(
  //           (x) => Task.fromMap(x as Map<String, dynamic>),
  //         ),
  //       ));
  // }
}
