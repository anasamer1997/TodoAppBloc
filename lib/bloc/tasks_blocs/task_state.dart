// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> favoritTasks;
  final List<Task> removedtasks;
  const TaskState({
    this.removedtasks = const <Task>[],
    this.completedTasks = const <Task>[],
    this.favoritTasks = const <Task>[],
    this.pendingTasks = const <Task>[],
  });

  @override
  List<Object> get props =>
      [pendingTasks, removedtasks, completedTasks, favoritTasks];

  TaskState copyWith({
    List<Task>? pendingTasks,
    List<Task>? removedtasks,
    List<Task>? completedTasks,
    List<Task>? favoritTasks,
  }) {
    return TaskState(
      pendingTasks: pendingTasks ?? this.pendingTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      favoritTasks: favoritTasks ?? this.favoritTasks,
      removedtasks: removedtasks ?? this.removedtasks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'favoritTasks': pendingTasks.map((x) => x.toMap()).toList(),
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
        favoritTasks: List<Task>.from(
          (map['favoritTasks'] as List<int>).map<Task>(
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
