import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/app_config.dart';
import '../../core/config/app_environment.dart';
import '../../core/logging/app_logger.dart';
import '../../core/analytics/analytics.dart';
import '../app.dart';
import 'app_providers.dart';
import 'root_error_handlers.dart';

/// No asynchronous plugin initialization, zones, network or storage in v1.
void bootstrap(AppEnvironment environment) {
  WidgetsFlutterBinding.ensureInitialized();
  const logger = NoopAppLogger();
  installRootErrorHandlers(logger);
  logger.record(AppLogEvent.startup);
  runApp(
    createAppRoot(
      config: AppConfig(environment: environment),
      logger: logger,
    ),
  );
}

Widget createAppRoot({
  required AppConfig config,
  AppLogger logger = const NoopAppLogger(),
  Analytics analytics = const NoopAnalytics(),
}) => ProviderScope(
  overrides: [
    appConfigProvider.overrideWithValue(config),
    appLoggerProvider.overrideWithValue(logger),
    analyticsProvider.overrideWithValue(analytics),
  ],
  // Riverpod 3 retries must be explicit per safe read; mutations never auto-retry.
  retry: (retryCount, error) => null,
  child: const LinguaApp(),
);
