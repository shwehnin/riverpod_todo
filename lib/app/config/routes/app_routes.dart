import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/config/routes/routes.dart';
import 'package:todo_app/app/pages/home/home_page.dart';
import 'package:todo_app/app/pages/create_task_page.dart';

final navigationKey = GlobalKey<NavigatorState>();

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomePage.builder,
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskPage.builder,
  ),
];
