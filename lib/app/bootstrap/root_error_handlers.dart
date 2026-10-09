import 'package:flutter/foundation.dart';

import '../../core/logging/app_logger.dart';

/// Returns a restoration callback for tests and embedded application hosts.
VoidCallback installRootErrorHandlers(AppLogger logger) {
  final previousFlutter = FlutterError.onError;
  final previousPlatform = PlatformDispatcher.instance.onError;
  FlutterError.onError = (details) {
    logger.record(AppLogEvent.frameworkError);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    logger.record(AppLogEvent.unhandledError);
    return true;
  };
  return () {
    FlutterError.onError = previousFlutter;
    PlatformDispatcher.instance.onError = previousPlatform;
  };
}
