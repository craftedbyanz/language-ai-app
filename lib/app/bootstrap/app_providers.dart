import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/app_config.dart';
import '../../core/logging/app_logger.dart';
import '../../core/analytics/analytics.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  throw StateError('AppConfig must be supplied by bootstrap.');
});
final appLoggerProvider = Provider<AppLogger>((ref) => const NoopAppLogger());
final analyticsProvider = Provider<Analytics>((ref) => const NoopAnalytics());
