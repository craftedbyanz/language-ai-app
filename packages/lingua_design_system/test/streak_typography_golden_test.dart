import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua_design_system/lingua_design_system.dart';
import 'package:lottie/lottie.dart';

void main() {
  for (final width in [390.0, 788.0, 1200.0]) {
    testWidgets('Vietnamese streak typography at $width', (tester) async {
      await tester.binding.setSurfaceSize(Size(width, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.runAsync(() async {
        final font = FontLoader(TypographyTokens.family)
          ..addFont(
            File('assets/fonts/PlusJakartaSans.ttf')
                .readAsBytes()
                .then((bytes) => ByteData.sublistView(bytes)),
          );
        await font.load();
        await (FontLoader(
          'MaterialIcons',
        )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
        await AssetLottie(
          'assets/animations/streak_flame_inactive.json',
          package: 'lingua_design_system',
        ).load();
      });
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          home: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: Scaffold(
              backgroundColor: ColorTokens.backgroundPlain,
              body: ContentConstraints(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppHeader(
                      variant: AppHeaderVariant.pushed,
                      leadingLabel: 'Quay lại',
                      onLeadingPressed: () {},
                      centre: const Text(
                        'Chuỗi Streak',
                        textAlign: TextAlign.center,
                        style: TypographyTokens.streakNavTitle,
                      ),
                    ),
                    const SizedBox(height: SpaceTokens.lg),
                    const InsightStreakSummary(
                      onFireLabel: 'ON FIRE',
                      count: '0',
                      unitLabel: 'ngày liên tiếp',
                      prompt: 'Bắt đầu chuỗi học tập ngay hôm nay!',
                      isActive: false,
                    ),
                    const SizedBox(height: SpaceTokens.xxl),
                    InsightCalendarCard(
                      variant: InsightCalendarVariant.streak,
                      title: 'tháng 10 năm 2026',
                      studiedDaysLabel: 'Đã học 0 ngày',
                      previousMonthLabel: 'Tháng trước',
                      nextMonthLabel: 'Tháng sau',
                      onPreviousMonth: () {},
                      weekdayLabels: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
                      leadingBlankDays: 4,
                      daysInMonth: 31,
                      lastElapsedDay: 17,
                    ),
                    const SizedBox(height: SpaceTokens.xl),
                    const Row(
                      children: [
                        Expanded(
                          child: InsightStreakStatCard(
                            icon: Icons.local_fire_department_rounded,
                            value: '0',
                            label: 'HIỆN TẠI',
                            accent: ColorTokens.warning,
                          ),
                        ),
                        SizedBox(width: SpaceTokens.md),
                        Expanded(
                          child: InsightStreakStatCard(
                            icon: Icons.bolt_rounded,
                            value: '0',
                            label: 'DÀI NHẤT',
                            accent: ColorTokens.warning,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('goldens/streak_typography_${width.toInt()}.png'),
      );
    });
  }
}
