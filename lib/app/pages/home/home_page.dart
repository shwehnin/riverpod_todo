import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/utils/utils.dart';
import 'package:todo_app/app/widgets/widgets.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app/providers/task/taskpds.dart';
import 'package:todo_app/app/providers/date_provider.dart';
import 'package:todo_app/app/config/routes/route_location.dart';

class HomePage extends ConsumerWidget {
  static HomePage builder(BuildContext context, GoRouterState state) =>
      const HomePage();
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);
    final completedTask = _completedTasks(taskState.tasks, ref);
    final incompletedTask = _incompletedTask(taskState.tasks, ref);
    final selectedDate = ref.watch(dateProvider);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * .3,
                width: deviceSize.width,
                color: colors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => Helpers.selectDate(context, ref),
                      child: DisplayWhiteText(
                        text: DateFormat.yMMMd().format(selectedDate),
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Gap(10),
                    const DisplayWhiteText(
                      text: "My Todo List",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 150,
            right: 0,
            left: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayTaskList(
                      tasks: incompletedTask,
                    ),
                    const Gap(20),
                    Text(
                      "Completed",
                      style: context.textTheme.headlineMedium,
                    ),
                    const Gap(20),
                    DisplayTaskList(
                      tasks: completedTask,
                      isCompletedTask: true,
                    ),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () => context.push(RouteLocation.createTask),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DisplayWhiteText(
                          text: "Add New Task",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Task> _completedTasks(List<Task> tasks, WidgetRef ref) {
    final selectedDate = ref.watch(dateProvider);
    final List<Task> filterTasks = [];
    for (var task in tasks) {
      final isTaskDay = Helpers.isTaskFromSelectedDate(task, selectedDate);

      if (task.isCompleted && isTaskDay) {
        filterTasks.add(task);
      }
    }
    return filterTasks;
  }

  List<Task> _incompletedTask(List<Task> tasks, WidgetRef ref) {
    final selectedDate = ref.watch(dateProvider);
    final List<Task> filterTasks = [];
    for (var task in tasks) {
      final isTaskDay = Helpers.isTaskFromSelectedDate(task, selectedDate);
      if (!task.isCompleted && isTaskDay) {
        filterTasks.add(task);
      }
    }
    return filterTasks;
  }
}
