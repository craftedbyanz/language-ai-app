import 'app_environment.dart';

final class FeatureFlags {
  const FeatureFlags();
  // DD-24 and DD-25: enabling either requires a new product decision.
  bool get paywallEnabled => false;
  bool get srsSwipeEnabled => false;
}

final class AppConfig {
  const AppConfig({
    required this.environment,
    this.flags = const FeatureFlags(),
  });
  final AppEnvironment environment;
  final FeatureFlags flags;
}
