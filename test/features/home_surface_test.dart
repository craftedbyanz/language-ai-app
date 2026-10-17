import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hifive/app/bootstrap/bootstrap.dart';
import 'package:hifive/core/config/app_config.dart';
import 'package:hifive/core/config/app_environment.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

void main() {
  for (final width in [390.0, 788.0, 954.0, 1200.0]) {
    testWidgets(
      'Home fills $width without side gutters or clipped active card',
      (tester) async {
        await tester.binding.setSurfaceSize(Size(width, 1083));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        await tester.pumpWidget(
          createAppRoot(
            config: const AppConfig(environment: AppEnvironment.production),
          ),
        );
        await tester.pumpAndSettle();
        final header = tester.getRect(
          find.byKey(const Key('home-greeting-row')),
        );
        expect(header.left, LayoutTokens.marginDashboard);
        expect(header.right, width - LayoutTokens.marginDashboard);
        final active = tester.getRect(
          find.byKey(const ValueKey('mode-card-01')),
        );
        expect(active.left, closeTo(LayoutTokens.marginDashboard, .1));
        expect(
          active.width,
          greaterThan((width - LayoutTokens.marginDashboard * 2) * .8),
        );
        final depth = tester
            .widgetList<HomeModeDepth>(find.byType(HomeModeDepth))
            .toList();
        expect(depth.first.active, isTrue);
        expect(
          tester.getRect(find.byKey(const Key('home-glass-dock'))).width,
          width,
        );
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('Home remains fitted after window resize and large text', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(954, 1083));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    addTearDown(
      tester.binding.platformDispatcher.clearTextScaleFactorTestValue,
    );
    await tester.pumpWidget(
      createAppRoot(
        config: const AppConfig(environment: AppEnvironment.production),
      ),
    );
    await tester.pumpAndSettle();
    await tester.binding.setSurfaceSize(const Size(390, 640));
    tester.binding.platformDispatcher.textScaleFactorTestValue = 2;
    await tester.pumpAndSettle();
    final header = tester.getRect(find.byKey(const Key('home-greeting-row')));
    expect(header.width, 390 - LayoutTokens.marginDashboard * 2);
    await tester.ensureVisible(find.byType(FeatureBanner));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  for (final width in [788.0, 954.0, 1200.0]) {
    testWidgets('Home materials golden at $width', (tester) async {
      await tester.binding.setSurfaceSize(Size(width, 1083));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.runAsync(() async {
        await (FontLoader(
          TypographyTokens.family,
        )..addFont(rootBundle.load('assets/fonts/PlusJakartaSans.ttf'))).load();
        await (FontLoader(
          'MaterialIcons',
        )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
      });
      await tester.pumpWidget(
        createAppRoot(
          config: const AppConfig(environment: AppEnvironment.production),
          initialLocale: const Locale('vi'),
        ),
      );
      await tester.pumpAndSettle();
      // Decode template artwork before capturing pixels in the fake-async test.
      await tester.runAsync(() async {
        final context = tester.element(find.byType(FloatingBottomBar));
        for (final name in ['review', 'menu', 'profile']) {
          await precacheImage(
            AssetImage(
              'assets/icons/home_dock/$name.png',
              package: 'lingua_design_system',
            ),
            context,
          );
        }
      });
      await tester.pump();
      for (final action in ['history', 'menu', 'profile']) {
        final artwork = tester.widget<RawImage>(
          find.descendant(
            of: find.byKey(ValueKey('home-dock-$action-glyph')),
            matching: find.byType(RawImage),
          ),
        );
        expect(artwork.image, isNotNull);
      }
      await expectLater(
        find.byType(AppScaffold),
        matchesGoldenFile('goldens/home_materials_${width.toInt()}.png'),
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('mode white text meets production body contrast', (tester) async {
    for (final fill in [
      FeatureTokens.homeWritingFill,
      FeatureTokens.homeGrammarFill,
      FeatureTokens.homeConversationFill,
    ]) {
      final contrast =
          (ColorTokens.textOnPrimary.computeLuminance() + .05) /
          (fill.computeLuminance() + .05);
      expect(contrast, greaterThanOrEqualTo(4.5));
    }
  });
}
