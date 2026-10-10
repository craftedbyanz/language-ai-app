import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../shell/foundation_page.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    routes: $appRoutes,
    initialLocation: const HomeRoute().location,
    errorBuilder: (context, state) => const FoundationPage(unavailable: true),
  );
  ref.onDispose(router.dispose);
  return router;
});
