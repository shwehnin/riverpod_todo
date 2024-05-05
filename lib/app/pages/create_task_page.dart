import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/data/data.dart';
import 'package:todo_app/app/utils/utils.dart';
import 'package:todo_app/app/widgets/widgets.dart';
import 'package:todo_app/app/providers/providers.dart';
import 'package:todo_app/app/config/routes/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateTaskPage extends ConsumerStatefulWidget {
  static CreateTaskPage builder(BuildContext context, GoRouterState state) =>
      const CreateTaskPage();
  const CreateTaskPage({super.key});

  @override
  ConsumerState<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends ConsumerState<CreateTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteText(text: "Add New Text"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CommonTaskField(
                    controller: _titleController,
                    title: 'Task Title',
                    hintText: 'Task Title'),
                const Gap(16),
                const SelectCategory(),
                const Gap(16),
                const SelectDateTime(),
                const Gap(16),
                CommonTaskField(
                  controller: _noteController,
                  title: 'Notes',
                  hintText: 'Note',
                  maxLines: 6,
                ),
                const Gap(16),
                ElevatedButton(
                  onPressed: _createTask,
                  child: const DisplayWhiteText(text: "Save"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final String title = _titleController.text.trim();
    final String note = _noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);

    if (title.isEmpty || note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill in all fields',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      return;
    }
    final task = Task(
      title: title,
      note: note,
      time: Helpers.timeToString(time),
      date: DateFormat.yMMMd().format(date),
      category: category,
      isCompleted: false,
    );
    await ref.read(taskProvider.notifier).createTask(task).then((value) {
      AppAlerts.displaySnackBar(context, "Task Created Successfully");
      context.go(RouteLocation.home);
    });
    _titleController.clear();
    _noteController.clear();
    // GoRouter.of(context).pop();
  }
}
