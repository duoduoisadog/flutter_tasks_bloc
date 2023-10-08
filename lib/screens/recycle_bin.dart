import 'package:bloc_demo/blocs/bloc_exports.dart';
import 'package:bloc_demo/screens/my_drawer.dart';
import 'package:bloc_demo/widgets/task_list.dart';
import 'package:flutter/material.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});

  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              PopupMenuButton(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: TextButton.icon(
                            onPressed: null,
                            icon: const Icon(Icons.delete_forever),
                            label: const Text("Delete all tasks"),
                          ),
                          onTap: () =>
                              context.read<TasksBloc>().add(DeleteAllTasks()),
                        ),
                      ]),
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Chip(label: Text("Tasks")),
              ),
              TaskList(tasklist: state.removedTasks)
            ],
          ),
        );
      },
    );
  }
}
