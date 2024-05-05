import 'package:todo_app/app/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryProvider = StateProvider<TaskCategories>((ref) {
  return TaskCategories.others;
});
