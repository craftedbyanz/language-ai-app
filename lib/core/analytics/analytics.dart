/// Extend reviewed event names when an actual product flow needs telemetry.
enum AnalyticsEvent { applicationStarted }

abstract interface class Analytics {
  void track(AnalyticsEvent event);
}

final class NoopAnalytics implements Analytics {
  const NoopAnalytics();
  @override
  void track(AnalyticsEvent event) {}
}
