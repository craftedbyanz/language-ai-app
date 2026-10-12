import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/app_config.dart';
import '../../core/config/app_environment.dart';
import '../../core/logging/app_logger.dart';
import '../../core/analytics/analytics.dart';
import '../../core/preferences/locale_preference.dart';
import '../app.dart';
import 'app_providers.dart';
import 'root_error_handlers.dart';

/// Load only non-sensitive device preferences before the first frame.
Future<void> bootstrap(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  const logger = NoopAppLogger();
  final localeStore = SharedPreferencesLocaleStore();
  Locale? initialLocale;
  try {
    initialLocale = await localeStore.load();
  } on Exception {
    // A preference read failure must not prevent the app from launching.
  }
  installRootErrorHandlers(logger);
  logger.record(AppLogEvent.startup);
  runApp(
    createAppRoot(
      config: AppConfig(environment: environment),
      logger: logger,
      initialLocale: initialLocale,
      localeStore: localeStore,
    ),
  );
}

Widget createAppRoot({
  required AppConfig config,
  AppLogger logger = const NoopAppLogger(),
  Analytics analytics = const NoopAnalytics(),
  Locale? initialLocale,
  LocalePreferenceStore? localeStore,
}) => ProviderScope(
  overrides: [
    appConfigProvider.overrideWithValue(config),
    appLoggerProvider.overrideWithValue(logger),
    analyticsProvider.overrideWithValue(analytics),
    initialLocaleProvider.overrideWithValue(initialLocale),
    if (localeStore != null)
      localePreferenceStoreProvider.overrideWithValue(localeStore),
  ],
  // Riverpod 3 retries must be explicit per safe read; mutations never auto-retry.
  retry: (retryCount, error) => null,
  child: const LinguaApp(),
);
