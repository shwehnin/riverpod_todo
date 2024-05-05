import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app/providers/task/taskpds.dart';
import 'package:todo_app/app/data/repositories/repositories.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});
