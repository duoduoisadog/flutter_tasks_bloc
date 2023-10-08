import 'package:bloc_demo/blocs/bloc_exports.dart';
import 'package:bloc_demo/models/task.dart';
import 'package:bloc_demo/widgets/task_list.dart';
import 'package:flutter/material.dart';

class FavoriteTaskScreen extends StatelessWidget {
  const FavoriteTaskScreen({super.key});
  static const id = 'task_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasklist = state.favoriteTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(label: Text("${tasklist.length} Tasks")),
            ),
            TaskList(tasklist: tasklist)
          ],
        );
      },
    );
  }
}
