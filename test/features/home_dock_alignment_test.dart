import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/bootstrap/bootstrap.dart';
import 'package:lingua/core/config/app_config.dart';
import 'package:lingua/core/config/app_environment.dart';

void main() {
  for (final width in [390.0, 788.0, 1200.0]) {
    testWidgets('Home dock actions share a baseline at width $width', (
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

      final history = tester.getCenter(find.byTooltip('History'));
      final menu = tester.getCenter(find.byTooltip('Menu'));
      final profile = tester.getCenter(find.byTooltip('Profile'));
      expect(history.dy, closeTo(menu.dy, 1));
      expect(profile.dy, closeTo(menu.dy, 1));
      expect((history.dx + profile.dx) / 2, closeTo(menu.dx, 1));
    });
  }
}
