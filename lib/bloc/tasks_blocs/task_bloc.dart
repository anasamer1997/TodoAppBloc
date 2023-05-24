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
          taskList: List.from(state.taskList)..add(event.task),
          removedtasks: state.removedtasks),
    );
  }

  void _UpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.taskList.indexOf(event.task);
    List<Task> allTask = List.from(state.taskList)..remove(task);
    task.isDone == false
        ? allTask.insert(index, task.copyWith(isDone: true))
        : allTask.insert(index, task.copyWith(isDone: false));
    emit(TaskState(taskList: allTask, removedtasks: state.removedtasks));
  }

  void _RemoveTask(RemoveTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
        taskList: List.from(state.taskList)..remove(event.task),
        removedtasks: List.from(state.removedtasks)
          ..add(event.task.copyWith(isDeleted: true))));
  }

  void _DeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
          taskList:
              state.taskList, // List.from(state.taskList)..remove(event.task),
          removedtasks: List.from(state.removedtasks)..remove(event.task)),
    );
  }

  // @override
  // TaskState? fromJson(Map<String, dynamic> json) {
  //   return TaskState.fromMap(json);
  // }

  // @override
  // Map<String, dynamic>? toJson(TaskState state) {
  //   return state.toMap();
  // }
}
