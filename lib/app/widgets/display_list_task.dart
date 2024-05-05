import 'package:flutter/material.dart';
import 'package:todo_app/app/utils/utils.dart';
import 'package:todo_app/app/widgets/widgets.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayTaskList extends ConsumerWidget {
  final List<Task> tasks;
  final bool isCompletedTask;

  const DisplayTaskList({
    super.key,
    required this.tasks,
    this.isCompletedTask = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final height =
        isCompletedTask ? deviceSize.height * .25 : deviceSize.height * .3;
    final emptyTasksMessage = isCompletedTask
        ? 'There is no completed task'
        : 'There is no task todo!';
    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyTasksMessage,
                style: context.textTheme.headlineSmall,
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: tasks.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return InkWell(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) => TaskDetails(task: task),
                      );
                    },
                    onLongPress: () {
                      AppAlerts.showDeleteAlertDialog(context, ref, task);
                    },
                    child: TaskTile(
                      task: task,
                      onCompleted: (vlaue) async {
                        await ref
                            .read(taskProvider.notifier)
                            .updateTask(task)
                            .then((value) {
                          AppAlerts.displaySnackBar(
                              context,
                              task.isCompleted
                                  ? "Task incompleted"
                                  : "Task completed");
                        });
                      },
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1.5,
                );
              },
            ),
    );
  }
}
