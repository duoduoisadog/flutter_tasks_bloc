import 'package:bloc_demo/blocs/bloc_exports.dart';
import 'package:bloc_demo/models/task.dart';
import 'package:bloc_demo/screens/edit_task_screen.dart';
import 'package:bloc_demo/widgets/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTitle extends StatelessWidget {
  const TaskTitle({
    super.key,
    required this.task,
  });

  final Task task;

  _removeOrDeleteTask(BuildContext context, Task task) {
    task.isDelete!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: EditTaskScreen(
                  oldTask: task,
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd HH:mm').format(
                          DateTime.parse(task.date),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDelete == false
                    ? (value) {
                        context.read<TasksBloc>().add(
                              UpdateTask(task: task),
                            );
                      }
                    : null,
              ),
              PopupMenu(
                task: task,
                cancelOrDeleteCallback: () =>
                    _removeOrDeleteTask(context, task),
                likeOrDislikeCallback: () => context.read<TasksBloc>().add(
                      MarkFavoriteOrUnfavoriteTask(task: task),
                    ),
                editTaskCallback: () {
                  _editTask(context);
                },
                restoreTaskCallback: () => context.read<TasksBloc>().add(
                      RestoreTask(task: task),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
