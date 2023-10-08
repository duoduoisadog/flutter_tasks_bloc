import 'package:bloc_demo/blocs/bloc_exports.dart';
import 'package:bloc_demo/models/task.dart';
import 'package:bloc_demo/widgets/task_list.dart';
import 'package:flutter/material.dart';

class PendingTaskScreen extends StatelessWidget {
  const PendingTaskScreen({super.key});
  static const id = 'task_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasklist = state.pendingTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  "${tasklist.length} Pending | ${state.completedTasks.length} Complete",
                ),
              ),
            ),
            TaskList(tasklist: tasklist)
          ],
        );
      },
    );
  }
}
