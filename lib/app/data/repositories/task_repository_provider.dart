import 'package:todo_app/app/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app/data/repositories/repositories.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final dataSource = ref.watch(taskDataSourceProvider);
  return TaskRepositoryImpl(dataSource);
});
