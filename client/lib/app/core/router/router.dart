import 'package:client/app/core/router/counstant_route.dart';
import 'package:client/app/modules/items/views/items_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _instance = _createRouter();

  static GoRouter get goRouter => _instance;

  static GoRouter _createRouter() {
    final router = GoRouter(routes: [
      GoRoute(
          path: "/",
          name: AppRoutes.items,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const ItemsPage()),
    ], navigatorKey: rootNavigatorKey, initialLocation: "/");
    return router;
  }
}
