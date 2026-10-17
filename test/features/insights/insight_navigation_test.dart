import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/bootstrap/bootstrap.dart';
import 'package:lingua/core/config/app_config.dart';
import 'package:lingua/core/config/app_environment.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

void main() {
  for (final width in [390.0, 788.0, 1200.0]) {
    testWidgets('Home history, streak and insight menu work at $width', (
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

      final gameTile = find.byType(FlowLetterTile);
      await tester.ensureVisible(gameTile);
      expect(gameTile, findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.byTooltip('History'));
      await tester.pumpAndSettle();
      expect(find.text('No history yet'), findsOneWidget);
      await tester.enterText(find.byType(SearchField), 'missing');
      await tester.pump();
      expect(find.text('No matching lessons'), findsOneWidget);
      await tester.tap(find.byKey(const Key('app-header-leading')));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(StreakPill));
      // The decorative flame loops continuously; allow only route transitions
      // to finish instead of waiting for every animation to settle.
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(StreakFlame), findsOneWidget);
      expect(find.text('CURRENT'), findsOneWidget);
      expect(find.text('LONGEST'), findsOneWidget);
      expect(find.byType(InsightCalendarCard), findsOneWidget);
      await tester.tap(find.byKey(const Key('app-header-leading')));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Menu'));
      await tester.pumpAndSettle();
      expect(find.byType(MenuOverlay), findsOneWidget);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();
      expect(find.byType(MenuOverlay), findsNothing);
      await tester.tap(find.byTooltip('Menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Insights'));
      await tester.pumpAndSettle();
      expect(find.byType(InsightStatCard), findsNWidgets(6));
      expect(find.byType(InsightWeekChartCard), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('compact Insight controls remain reachable at 200% text', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 640));
    tester.binding.platformDispatcher.textScaleFactorTestValue = 2;
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
    await tester.tap(find.byTooltip('Menu'));
    await tester.pumpAndSettle();
    expect(find.byType(MenuOverlay), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Insights'));
    await tester.pumpAndSettle();
    expect(find.byType(InsightCalendarCard), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  for (final scale in [1.0, 2.0]) {
    testWidgets('Vietnamese Streak labels and scaling at $scale', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 900));
      tester.binding.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(() => tester.binding.setSurfaceSize(null));
      addTearDown(
        tester.binding.platformDispatcher.clearTextScaleFactorTestValue,
      );
      await tester.pumpWidget(
        createAppRoot(
          config: const AppConfig(environment: AppEnvironment.production),
          initialLocale: const Locale('vi'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(StreakPill));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Chuỗi Streak'), findsOneWidget);
      expect(find.text('HIỆN TẠI'), findsOneWidget);
      expect(find.text('DÀI NHẤT'), findsOneWidget);
      expect(find.text('Chuỗi hiện tại'), findsNothing);
      final unit = tester.widget<Text>(find.text('ngày liên tiếp'));
      expect(
        unit.style,
        TypographyTokens.streakUnit.copyWith(color: ColorTokens.textSecondary),
      );
      await tester.ensureVisible(find.text('DÀI NHẤT'));
      await tester.pump();
      expect(tester.takeException(), isNull);
      await tester.tap(find.byKey(const Key('app-header-leading')));
      await tester.pumpAndSettle();
    });
  }
}
