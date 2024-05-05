import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/data/repositories/repositories.dart';
import 'package:todo_app/app/data/data_source/task_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource _taskDataSource;

  TaskRepositoryImpl(this._taskDataSource);
  @override
  Future<void> createTask(Task task) async {
    try {
      await _taskDataSource.addTask(task);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    try {
      await _taskDataSource.deleteTask(task);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<List<Task>> getAllTasks() async {
    try {
      return await _taskDataSource.getAllTasks();
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    try {
      await _taskDataSource.updateTask(task);
    } catch (e) {
      throw '$e';
    }
  }
}
