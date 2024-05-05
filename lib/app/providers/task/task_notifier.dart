import 'package:flutter/material.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app/providers/task/taskpds.dart';
import 'package:todo_app/app/data/repositories/repositories.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final TaskRepository _repository;
  TaskNotifier(this._repository) : super(const TaskState.initial()) {
    getAllTasks();
  }

  Future<void> createTask(Task task) async {
    try {
      await _repository.createTask(task);
      getAllTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final isCompleted = !task.isCompleted;
      final updateTask = task.copyWith(isCompleted: isCompleted);
      await _repository.updateTask(updateTask);
      getAllTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTask(task);
      getAllTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getAllTasks() async {
    try {
      final tasks = await _repository.getAllTasks();
      state = state.copyWith(tasks: tasks);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
