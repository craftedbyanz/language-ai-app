import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/bootstrap/app_providers.dart';
import 'package:lingua/app/bootstrap/bootstrap.dart';
import 'package:lingua/app/bootstrap/root_error_handlers.dart';
import 'package:lingua/app/router/app_router.dart';
import 'package:lingua/app/router/app_routes.dart';
import 'package:lingua/core/config/app_config.dart';
import 'package:lingua/core/config/app_environment.dart';
import 'package:lingua/core/logging/app_logger.dart';

final class FakeLogger implements AppLogger {
  final events = <AppLogEvent>[];
  @override
  void record(AppLogEvent event) => events.add(event);
}

void main() {
  testWidgets('all environments boot through one overridable root', (
    tester,
  ) async {
    for (final environment in AppEnvironment.values) {
      await tester.pumpWidget(
        createAppRoot(config: AppConfig(environment: environment)),
      );
      await tester.pumpAndSettle();
      final context = tester.element(find.text('Good morning'));
      final container = ProviderScope.containerOf(context);
      final config = container.read(appConfigProvider);
      expect(config.environment, environment);
      expect(config.flags.paywallEnabled, isFalse);
      expect(config.flags.srsSwipeEnabled, isFalse);
      expect(const HomeRoute().location, '/');
      container.read(appRouterProvider).go('/unknown');
      await tester.pumpAndSettle();
      expect(find.text('This page is unavailable.'), findsOneWidget);
      const HomeRoute().go(
        tester.element(find.text('This page is unavailable.')),
      );
      await tester.pumpAndSettle();
      expect(find.text('Good morning'), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
    }
  });
  test('root errors expose only reviewed event names and restore handlers', () {
    final logger = FakeLogger();
    final previousFlutter = FlutterError.onError;
    final previousPlatform = PlatformDispatcher.instance.onError;
    final restore = installRootErrorHandlers(logger);
    try {
      FlutterError.onError!(
        FlutterErrorDetails(exception: StateError('sensitive payload')),
      );
      expect(
        PlatformDispatcher.instance.onError!(
          StateError('sensitive payload'),
          StackTrace.current,
        ),
        isTrue,
      );
      expect(logger.events, [
        AppLogEvent.frameworkError,
        AppLogEvent.unhandledError,
      ]);
    } finally {
      restore();
    }
    expect(FlutterError.onError, same(previousFlutter));
    expect(PlatformDispatcher.instance.onError, same(previousPlatform));
  });
}
