import 'package:flutter/material.dart';
import 'package:todo_app/app/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app/config/routes/routes.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.watch(routesProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      theme: AppTheme.light,
      routerConfig: routeConfig,
    );
  }
}
