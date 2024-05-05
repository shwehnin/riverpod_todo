import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app/data/data_source/task_data_source.dart';

final taskDataSourceProvider = Provider<TaskDataSource>((ref) {
  return TaskDataSource();
});
