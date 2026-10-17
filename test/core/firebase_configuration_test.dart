import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hifive/core/config/app_environment.dart';
import 'package:hifive/core/firebase/firebase_bootstrap.dart';
import 'package:hifive/core/firebase/firebase_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() => debugDefaultTargetPlatformOverride = null);

  test('development options select the registered app on each native host', () {
    for (final platform in [
      TargetPlatform.android,
      TargetPlatform.iOS,
      TargetPlatform.macOS,
    ]) {
      debugDefaultTargetPlatformOverride = platform;
      final options = firebaseOptionsForEnvironment(
        AppEnvironment.development,
      )!;
      expect(options.projectId, 'hifive-dev-8189c');
      if (platform != TargetPlatform.android) {
        expect(options.iosBundleId, 'com.anznguyen.hifive');
      }
    }
  });

  test(
    'unconfigured environments never initialize the development project',
    () async {
      for (final environment in [
        AppEnvironment.staging,
        AppEnvironment.production,
      ]) {
        expect(firebaseOptionsForEnvironment(environment), isNull);
        expect(await initializeFirebase(environment), isNull);
      }
    },
  );

  test('an uninjected root cannot silently access default Firebase Auth', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(
      () => container.read(firebaseAppProvider),
      throwsA(isA<Exception>()),
    );
    expect(
      () => container.read(firebaseAuthProvider),
      throwsA(isA<Exception>()),
    );
  });
}
