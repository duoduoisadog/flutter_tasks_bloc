import 'package:bloc_demo/blocs/bloc_exports.dart';
import 'package:bloc_demo/models/task.dart';
import 'package:equatable/equatable.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTasks);
  }
  _onDeleteAllTasks(DeleteAllTasks event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)..clear(),
      ),
    );
  }

  _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..insert(
            0,
            event.task.copyWith(
              isDelete: false,
              isDone: false,
              isFavorite: false,
            ),
          ),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task),
      ),
    );
  }

  _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.oldTask.isFavorite == true) {
      favoriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTasks: List.from(state.completedTasks)..remove(event.oldTask),
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  _onMarkFavoriteOrUnfavoriteTask(
      MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isFavorite: true),
          );
        favoriteTasks = List.from(favoriteTasks)
          ..insert(
            0,
            event.task.copyWith(isFavorite: true),
          );
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isFavorite: false),
          );
        favoriteTasks = List.from(favoriteTasks)
          ..remove(
            event.task,
          );
      }
    } else {
      var taskIndex = completedTasks.indexOf(event.task);
      if (event.task.isFavorite == false) {
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isFavorite: true),
          );
        favoriteTasks = List.from(favoriteTasks)
          ..insert(
            0,
            event.task.copyWith(isFavorite: true),
          );
      } else {
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isFavorite: false),
          );
        favoriteTasks = List.from(favoriteTasks)
          ..remove(
            event.task,
          );
      }
    }

    emit(
      TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(
            event.task.copyWith(isDelete: true),
          ),
      ),
    );
  }

  _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      removedTasks: state.removedTasks,
    ));
  }

  _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (task.isDone == false) {
      if (task.isFavorite == false) {
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks = List.from(completedTasks)
          ..insert(
            0,
            task.copyWith(isDone: true),
          );
      } else {
        var taskIndex = favoriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks = List.from(completedTasks)
          ..insert(
            0,
            task.copyWith(isDone: true),
          );
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(
            taskIndex,
            task.copyWith(isDone: true),
          );
      }
    } else {
      if (task.isFavorite == false) {
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(
            0,
            task.copyWith(isDone: false),
          );
      } else {
        var taskIndex = favoriteTasks.indexOf(task);
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(
            0,
            task.copyWith(isDone: false),
          );
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(
            taskIndex,
            task.copyWith(isDone: false),
          );
      }
    }
    emit(
      TasksState(
        pendingTasks: pendingTasks,
        removedTasks: state.removedTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
      ),
    );
  }

  _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        pendingTasks: state.pendingTasks,
        removedTasks: List.from(state.removedTasks)
          ..remove(
            event.task,
          ),
      ),
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
