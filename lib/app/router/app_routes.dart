import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../shell/foundation_page.dart';

part 'app_routes.g.dart';

@TypedGoRoute<FoundationRoute>(path: '/')
class FoundationRoute extends GoRouteData with $FoundationRoute {
  const FoundationRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FoundationPage();
}
