import 'dart:ui' show SemanticsAction;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

void main() {
  testWidgets(
    'dock controls keep 44px clickable targets, semantics and keyboard activation',
    (tester) async {
      final semantics = tester.ensureSemantics();
      final activations = [0, 0, 0];
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: FloatingBottomBar(
                streakCount: 0,
                streakLabel: 'Streak: 0 days',
                historyLabel: 'History',
                menuLabel: 'Menu',
                settingsLabel: 'Profile',
                onHistory: () => activations[0]++,
                onMenu: () => activations[1]++,
                onSettings: () => activations[2]++,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      for (final action in ['history', 'menu', 'profile']) {
        final rect = tester.getRect(
          find.byKey(ValueKey('home-dock-$action-hit-target')),
        );
        expect(rect.width, greaterThanOrEqualTo(ControlTokens.minTouchTarget));
        expect(rect.height, greaterThanOrEqualTo(ControlTokens.minTouchTarget));
        await tester.tapAt(Offset(rect.left + 1, rect.center.dy));
        await tester.pumpAndSettle();
      }
      expect(activations, [1, 1, 1]);
      for (final label in ['History', 'Menu', 'Profile']) {
        expect(
          tester
              .getSemantics(find.bySemanticsLabel(label))
              .getSemanticsData()
              .hasAction(SemanticsAction.tap),
          isTrue,
        );
      }
      // Move back to the first button, then traverse and activate the three actions.
      final firstInk = tester.widget<InkWell>(
        find.byKey(const ValueKey('home-dock-history-button')),
      );
      final focus = Focus.of(
        tester.element(find.byKey(const ValueKey('home-dock-history-button'))),
      );
      expect(firstInk.onTap, isNotNull);
      focus.unfocus();
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(activations.reduce((a, b) => a + b), 4);
      expect(tester.takeException(), isNull);
      semantics.dispose();
    },
  );

  for (final scale in [1.0, 2.0]) {
    testWidgets('dock control artwork at text scale $scale', (tester) async {
      await tester.runAsync(() async {
        await (FontLoader(
          TypographyTokens.family,
        )..addFont(rootBundle.load('assets/fonts/PlusJakartaSans.ttf'))).load();
        await (FontLoader(
          'MaterialIcons',
        )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
      });
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: RepaintBoundary(
                key: const Key('dock-capture'),
                child: MediaQuery(
                  data: MediaQueryData(textScaler: TextScaler.linear(scale)),
                  child: SizedBox(
                    width: 390,
                    height:
                        LayoutTokens.homeDockHeight +
                        LayoutTokens.homeDockFadeHeight,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorTokens.primaryTint,
                            ColorTokens.surfaceMuted,
                          ],
                        ),
                      ),
                      child: FloatingBottomBar(
                        streakCount: 0,
                        streakLabel: 'Chuỗi: 0 ngày',
                        historyLabel: 'Ôn tập',
                        menuLabel: 'Menu',
                        settingsLabel: 'Profile',
                        onHistory: () {},
                        onMenu: () {},
                        onSettings: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
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
        find.byKey(const Key('dock-capture')),
        matchesGoldenFile('goldens/home_dock_${scale.toInt()}x.png'),
      );
    });
  }
}
