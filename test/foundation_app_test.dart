import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hifive/app/bootstrap/bootstrap.dart';
import 'package:hifive/core/config/app_config.dart';
import 'package:hifive/core/config/app_environment.dart';

void main() {
  testWidgets('localized placeholder survives narrow windows and large text', (
    tester,
  ) async {
    tester.platformDispatcher.localesTestValue = const [Locale('vi')];
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    addTearDown(() => tester.binding.setSurfaceSize(null));
    for (final size in [
      const Size(320, 480),
      const Size(788, 1083),
      const Size(1440, 500),
    ]) {
      await tester.binding.setSurfaceSize(size);
      await tester.pumpWidget(
        createAppRoot(
          config: const AppConfig(environment: AppEnvironment.production),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Chào buổi sáng'), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
  });
}
