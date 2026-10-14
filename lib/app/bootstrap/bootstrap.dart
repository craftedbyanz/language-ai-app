import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/app_config.dart';
import '../../core/config/app_environment.dart';
import '../../core/logging/app_logger.dart';
import '../../core/analytics/analytics.dart';
import '../../core/preferences/locale_preference.dart';
import '../../core/preferences/device_preferences.dart';
import '../app.dart';
import 'app_providers.dart';
import 'root_error_handlers.dart';

/// Load only non-sensitive device preferences before the first frame.
Future<void> bootstrap(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  const logger = NoopAppLogger();
  final localeStore = SharedPreferencesLocaleStore();
  final deviceStore = SharedDevicePreferencesStore();
  Locale? initialLocale;
  DevicePreferences initialDevicePreferences = const DevicePreferences();
  try {
    initialLocale = await localeStore.load();
  } on Exception {
    // A preference read failure must not prevent the app from launching.
  }
  try {
    initialDevicePreferences = await deviceStore.load();
  } on Exception {
    // Device preferences fall back to canonical defaults.
  }
  installRootErrorHandlers(logger);
  logger.record(AppLogEvent.startup);
  runApp(
    createAppRoot(
      config: AppConfig(environment: environment),
      logger: logger,
      initialLocale: initialLocale,
      localeStore: localeStore,
      deviceStore: deviceStore,
      initialDevicePreferences: initialDevicePreferences,
    ),
  );
}

Widget createAppRoot({
  required AppConfig config,
  AppLogger logger = const NoopAppLogger(),
  Analytics analytics = const NoopAnalytics(),
  Locale? initialLocale,
  LocalePreferenceStore? localeStore,
  DevicePreferencesStore? deviceStore,
  DevicePreferences initialDevicePreferences = const DevicePreferences(),
}) => ProviderScope(
  overrides: [
    appConfigProvider.overrideWithValue(config),
    appLoggerProvider.overrideWithValue(logger),
    analyticsProvider.overrideWithValue(analytics),
    initialLocaleProvider.overrideWithValue(initialLocale),
    initialDevicePreferencesProvider.overrideWithValue(
      initialDevicePreferences,
    ),
    if (deviceStore != null)
      devicePreferencesStoreProvider.overrideWithValue(deviceStore),
    if (localeStore != null)
      localePreferenceStoreProvider.overrideWithValue(localeStore),
  ],
  // Riverpod 3 retries must be explicit per safe read; mutations never auto-retry.
  retry: (retryCount, error) => null,
  child: const LinguaApp(),
);
