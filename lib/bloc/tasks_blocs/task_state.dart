// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> favouriteTasks;
  final List<Task> removedtasks;
  const TaskState({
    this.removedtasks = const <Task>[],
    this.completedTasks = const <Task>[],
    this.favouriteTasks = const <Task>[],
    this.pendingTasks = const <Task>[],
  });

  @override
  List<Object> get props =>
      [pendingTasks, removedtasks, completedTasks, favouriteTasks];

  TaskState copyWith({
    List<Task>? pendingTasks,
     List<Task>? completedTasks,
    List<Task>? favouriteTasks,
    List<Task>? removedtasks,
   
  }) {
    return TaskState(
      pendingTasks: pendingTasks ?? this.pendingTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      favouriteTasks: favouriteTasks ?? this.favouriteTasks,
      removedtasks: removedtasks ?? this.removedtasks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'favouriteTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'removedtasks': pendingTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
        pendingTasks: List<Task>.from(
          (map['pendingTasks'] as List<int>).map<Task>(
            (x) => Task.fromMap(x as Map<String, dynamic>),
          ),
        ),
        completedTasks: List<Task>.from(
          (map['completedTasks'] as List<int>).map<Task>(
            (x) => Task.fromMap(x as Map<String, dynamic>),
          ),
        ),
        favouriteTasks: List<Task>.from(
          (map['favouriteTasks'] as List<int>).map<Task>(
            (x) => Task.fromMap(x as Map<String, dynamic>),
          ),
        ),
        removedtasks: List<Task>.from(
          (map['removedtasks'] as List<int>).map<Task>(
            (x) => Task.fromMap(x as Map<String, dynamic>),
          ),
        ));
  }
}
