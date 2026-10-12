import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/bootstrap/bootstrap.dart';
import 'package:lingua/core/config/app_config.dart';
import 'package:lingua/core/config/app_environment.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

void main() {
  for (final width in [390.0, 788.0, 1200.0]) {
    testWidgets('Flashcard entry and detail work at width $width', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(Size(width, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        createAppRoot(
          config: const AppConfig(environment: AppEnvironment.production),
        ),
      );
      await tester.pumpAndSettle();

      final banner = find.byType(FeatureBanner);
      await tester.ensureVisible(banner);
      await tester.tap(banner);
      await tester.pumpAndSettle();
      expect(find.text('Daily life'), findsOneWidget);
      expect(find.text('Travel essentials'), findsOneWidget);

      await tester.tap(find.text('Daily life'));
      await tester.pumpAndSettle();
      expect(find.text('routine'), findsOneWidget);
      expect(find.text('thói quen'), findsOneWidget);
      expect(find.text('Review (0)'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
