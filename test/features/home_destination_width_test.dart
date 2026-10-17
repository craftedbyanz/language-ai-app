import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hifive/app/bootstrap/bootstrap.dart';
import 'package:hifive/core/config/app_config.dart';
import 'package:hifive/core/config/app_environment.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

void main() {
  for (final destination in ['Profile', 'Review']) {
    testWidgets('$destination fills the window after opening and resizing', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(954, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        createAppRoot(
          config: const AppConfig(environment: AppEnvironment.production),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(destination));
      await tester.pumpAndSettle();

      for (final width in [954.0, 390.0, 788.0, 1200.0]) {
        await tester.binding.setSurfaceSize(Size(width, 900));
        await tester.pumpAndSettle();
        final regions = find.byType(ContentConstraints);
        expect(regions, findsNWidgets(2)); // Header and scroll body.
        for (var index = 0; index < 2; index++) {
          final content = find
              .descendant(
                of: regions.at(index),
                matching: find.byType(ConstrainedBox),
              )
              .first;
          final rect = tester.getRect(content);
          expect(rect.left, LayoutTokens.marginDashboard);
          expect(rect.right, width - LayoutTokens.marginDashboard);
        }
        expect(tester.takeException(), isNull);
      }
    });
  }
}
