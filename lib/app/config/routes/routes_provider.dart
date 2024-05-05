import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app/config/routes/routes.dart';

final routesProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteLocation.home,
    routes: appRoutes,
    navigatorKey: navigationKey,
  );
});
