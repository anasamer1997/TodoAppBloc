import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/bloc/bloc_export.dart';
import 'package:flutter_tasks_app/models/taskModel.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState()) {
    on<AddTaskEvent>(_AddTask);
    on<UpdateTaskEvent>(_UpdateTask);
    on<DeleteTaskEvent>(_DeleteTask);
    on<RemoveTaskEvent>(_RemoveTask);
  }

  void _AddTask(AddTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        removedtasks: state.removedtasks,
        completedTasks: state.completedTasks,
        favoritTasks: state.favoritTasks,
      ),
    );
  }

  void _UpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    // List<Task> favoriteTasks = state.favoritTasks;
    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: true)),
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false)),
          };
    emit(TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoritTasks: state.favoritTasks,
        removedtasks: state.removedtasks));
  }

  void _RemoveTask(RemoveTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
        favoritTasks: List.from(state.favoritTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        removedtasks: List.from(state.removedtasks)
          ..add(event.task.copyWith(isDeleted: true))));
  }

  void _DeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
          pendingTasks: state.pendingTasks,
          completedTasks: state.completedTasks,
          favoritTasks: state
              .favoritTasks, // List.from(state.taskList)..remove(event.task),
          removedtasks: List.from(state.removedtasks)..remove(event.task)),
    );
  }

  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
