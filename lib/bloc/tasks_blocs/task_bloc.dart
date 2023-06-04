import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/bloc/bloc_export.dart';
import 'package:flutter_tasks_app/models/taskModel.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTaskEvent>(_AddTask);
    on<UpdateTaskEvent>(_UpdateTask);
    on<DeleteTaskEvent>(_DeleteTask);
    on<RemoveTaskEvent>(_RemoveTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTaskEvent>(_onEditTask);
    on<TaskRestorEvent>(_onRestoreTask);
    on<AllTasksDeletedEvent>(_onDeleteAllTask);
  }

  void _AddTask(AddTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        removedtasks: state.removedtasks,
        completedTasks: state.completedTasks,
        favouriteTasks: state.favouriteTasks,
      ),
    );
  }

void _UpdateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favouriteTasks;

    if (task.isDone == false) {
      if (task.isFavourite == false) {
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks = List.from(completedTasks)..insert(0,task.copyWith(isDone: true));
      } 
      else {
        var taskIndex = favoriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(event.task);
        completedTasks = List.from(completedTasks)..insert(0,task.copyWith(isDone: true));
        favoriteTasks = List.from(favoriteTasks)
        ..remove(task)
        ..insert(0,task.copyWith(isDone: true));
      }
    } else {
      if (task.isFavourite == false) {
        var taskIndex = completedTasks.indexOf(task);
        completedTasks = List.from(completedTasks)
        ..remove(event.task);
        pendingTasks = List.from(pendingTasks)
        ..insert(0,task.copyWith(isDone: false));
      } else {
        var taskIndex = completedTasks.indexOf(task);
        completedTasks = List.from(completedTasks)
        ..remove(task);
      
        pendingTasks = List.from(pendingTasks)
        ..insert(0,task.copyWith(isDone: false));
        favoriteTasks = List.from(favoriteTasks)
        ..remove(task)
        ..insert(taskIndex, task.copyWith(isDone: false));
      }
    }
    emit(TaskState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favouriteTasks: favoriteTasks,
      removedtasks: state.removedtasks,
    ));
  }

  void _RemoveTask(RemoveTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
        favouriteTasks: List.from(state.favouriteTasks)..remove(event.task),
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
          favouriteTasks: state
              .favouriteTasks, // List.from(state.taskList)..remove(event.task),
          removedtasks: List.from(state.removedtasks)..remove(event.task)),
    );
  }

  void _onMarkFavoriteOrUnfavoriteTask(
      MarkFavoriteOrUnfavoriteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favouriteTasks;

    if (event.task.isDone == false) {
      if (event.task.isFavourite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favoriteTasks = List.from(favoriteTasks)..insert(0, event.task.copyWith(isFavourite: true));
      } 
      else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
          
        favoriteTasks = List.from(favoriteTasks)..remove(event.task.copyWith(isFavourite: false));
      }
    } else {
      if (event.task.isFavourite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favoriteTasks = List.from(favoriteTasks)
        ..insert(taskIndex, event.task.copyWith(isFavourite: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favoriteTasks = List.from(favoriteTasks)
        ..remove(event.task);
      }
    }
    emit(TaskState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favouriteTasks: favoriteTasks,
      removedtasks: state.removedtasks,
    ));
  }

 void _onEditTask(EditTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    List<Task> favouriteTasks = state.favouriteTasks;
    if (event.oldTask.isFavourite == true) {
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(
      TaskState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTasks: List.from(state.completedTasks)..remove(event.oldTask),
        favouriteTasks: favouriteTasks,
        removedtasks: state.removedtasks,
      ),
    );
  }

  void _onRestoreTask(TaskRestorEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
        removedtasks: List.from(state.removedtasks)..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)
          ..insert(
              0,
              event.task.copyWith(
                isDeleted: false,
                isDone: false,
                isFavourite: false,
              )),
        completedTasks: state.completedTasks,
        favouriteTasks: state.favouriteTasks,
      ),
    );
  }

  void _onDeleteAllTask(AllTasksDeletedEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
        removedtasks: List.from(state.removedtasks)..clear(),
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favouriteTasks: state.favouriteTasks,
      ),
    );
  }

  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
