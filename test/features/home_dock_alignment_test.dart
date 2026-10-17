import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hifive/app/bootstrap/bootstrap.dart';
import 'package:hifive/core/config/app_config.dart';
import 'package:hifive/core/config/app_environment.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

void main() {
  for (final width in [280.0, 390.0, 788.0, 954.0, 1200.0]) {
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

      final history = tester.getCenter(find.byTooltip('Review'));
      final menu = tester.getCenter(find.byTooltip('Menu'));
      final profile = tester.getCenter(find.byTooltip('Profile'));
      expect(history.dy, closeTo(menu.dy, 1));
      expect(profile.dy, closeTo(menu.dy, 1));
      expect((history.dx + profile.dx) / 2, closeTo(menu.dx, 1));
      final surfaces = <String, Rect>{
        for (final action in ['history', 'menu', 'profile'])
          action: tester.getRect(
            find.byKey(ValueKey('home-dock-$action-surface')),
          ),
      };
      expect(surfaces['menu']!.center.dx, closeTo(width / 2, .01));
      expect(
        surfaces['menu']!.center.dy,
        closeTo(
          900 -
              ControlTokens.minTouchTarget / 2 -
              LayoutTokens.homeDockControlsBottomInset,
          .01,
        ),
      );
      expect(
        surfaces['history']!.center.dy,
        closeTo(surfaces['menu']!.center.dy, .01),
      );
      expect(
        surfaces['profile']!.center.dy,
        closeTo(surfaces['menu']!.center.dy, .01),
      );
      for (final action in ['history', 'profile']) {
        final glyph = tester.getRect(
          find.byKey(ValueKey('home-dock-$action-glyph')),
        );
        expect(glyph.center.dx, closeTo(surfaces[action]!.center.dx, .01));
        expect(glyph.center.dy, closeTo(surfaces[action]!.center.dy, .01));
        expect(surfaces[action]!.width, surfaces[action]!.height);
      }
      final glyph = tester.getRect(
        find.byKey(const ValueKey('home-dock-menu-glyph')),
      );
      final label = tester.getRect(
        find.byKey(const Key('home-dock-menu-label')),
      );
      expect(glyph.center.dy, closeTo(surfaces['menu']!.center.dy, .01));
      expect(label.center.dy, closeTo(surfaces['menu']!.center.dy, .01));
      expect((glyph.left + label.right) / 2, closeTo(width / 2, .01));
      expect(find.text('Menu'), findsOneWidget);
    });
  }
}
