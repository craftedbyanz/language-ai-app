/// Closed events deliberately exclude exception messages, payloads and PII.
enum AppLogEvent { startup, frameworkError, unhandledError }

abstract interface class AppLogger {
  void record(AppLogEvent event);
}

final class NoopAppLogger implements AppLogger {
  const NoopAppLogger();
  @override
  void record(AppLogEvent event) {}
}
