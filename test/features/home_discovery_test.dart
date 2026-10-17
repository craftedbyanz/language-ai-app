import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/bootstrap/bootstrap.dart';
import 'package:lingua/core/config/app_config.dart';
import 'package:lingua/core/config/app_environment.dart';
import 'package:lingua/features/writing/writing.dart';
import 'package:lingua/features/flashcards/flashcards.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

Future<void> _home(WidgetTester tester, double width, double scale) async {
  await tester.binding.setSurfaceSize(Size(width, 1083));
  tester.binding.platformDispatcher.textScaleFactorTestValue = scale;
  addTearDown(() => tester.binding.setSurfaceSize(null));
  addTearDown(tester.binding.platformDispatcher.clearTextScaleFactorTestValue);
  await tester.pumpWidget(
    createAppRoot(
      config: const AppConfig(environment: AppEnvironment.production),
      initialLocale: const Locale('vi'),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  for (final variant in [
    (390.0, 1.0),
    (788.0, 1.0),
    (1200.0, 1.0),
    (390.0, 2.0),
  ]) {
    final (width, scale) = variant;
    testWidgets('Home discovery fits and renders at $width / $scale', (
      tester,
    ) async {
      await tester.runAsync(() async {
        await (FontLoader(
          TypographyTokens.family,
        )..addFont(rootBundle.load('assets/fonts/PlusJakartaSans.ttf'))).load();
        await (FontLoader(
          'MaterialIcons',
        )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
      });
      await _home(tester, width, scale);
      expect(find.byType(HomeRecommendationChip), findsNWidgets(10));
      await tester.ensureVisible(find.byKey(const Key('home-guide-rail')));
      await tester.pumpAndSettle();
      await tester.runAsync(() async {
        final context = tester.element(find.byType(AppScaffold));
        for (final image in tester.widgetList<Image>(find.byType(Image))) {
          await precacheImage(image.image, context);
        }
      });
      await tester.pump();
      final recommendationTop = tester
          .getTopLeft(find.byKey(const Key('home-recommendations-heading')))
          .dy;
      final flashcardTop = tester.getTopLeft(find.byType(FeatureBanner)).dy;
      final gameTop = tester.getTopLeft(find.byType(FlowLetterTile)).dy;
      final guideTop = tester
          .getTopLeft(find.byKey(const Key('home-guide-heading')))
          .dy;
      expect(recommendationTop, lessThan(flashcardTop));
      expect(flashcardTop, lessThan(gameTop));
      expect(gameTop, lessThan(guideTop));
      expect(
        tester.getSize(find.byType(FlowLetterTile)).width,
        width - LayoutTokens.marginDashboard * 2,
      );
      expect(tester.takeException(), isNull);
      await expectLater(
        find.byType(AppScaffold),
        matchesGoldenFile(
          'goldens/home_discovery_${width.toInt()}_${scale.toInt()}x.png',
        ),
      );
    });
  }

  testWidgets(
    'recommendation opens existing matching practice without generating a lesson',
    (tester) async {
      await _home(tester, 788, 1);
      final chip = find.byKey(const ValueKey('home-topic-travel'));
      await tester.ensureVisible(chip);
      await tester.tap(chip);
      await tester.pumpAndSettle();
      expect(find.textContaining('Tạo bài học mới bằng AI'), findsOneWidget);
      await tester.tap(find.text('Xem bài luyện'));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<WritingLessonListScreen>(
              find.byType(WritingLessonListScreen),
            )
            .topicId,
        'travel',
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'all seven 101 tiles open guides and close without losing Home position',
    (tester) async {
      await _home(tester, 390, 1);
      final rail = find.byKey(const Key('home-guide-rail'));
      await tester.ensureVisible(rail);
      await tester.pumpAndSettle();
      for (final kind in HomeGuideKind.values) {
        final tile = find.byKey(ValueKey('home-guide-${kind.name}'));
        await tester.scrollUntilVisible(
          tile,
          100,
          scrollable: find
              .descendant(of: rail, matching: find.byType(Scrollable))
              .first,
        );
        await tester.tap(tile);
        await tester.pumpAndSettle();
        expect(find.byType(BottomSheet), findsOneWidget);
        if (kind == HomeGuideKind.game) {
          expect(find.textContaining('chưa mở để chơi'), findsOneWidget);
          expect(
            find.descendant(
              of: find.byType(BottomSheet),
              matching: find.byType(AppButton),
            ),
            findsNothing,
          );
        }
        await tester.tap(find.byTooltip('Đóng'));
        await tester.pumpAndSettle();
        expect(find.byType(BottomSheet), findsNothing);
        expect(tester.takeException(), isNull);
      }
    },
  );
  testWidgets('101 Flashcard shortcut opens its real destination', (
    tester,
  ) async {
    await _home(tester, 788, 1);
    final rail = find.byKey(const Key('home-guide-rail'));
    await tester.ensureVisible(rail);
    await tester.pumpAndSettle();
    final tile = find.byKey(const ValueKey('home-guide-flashcards'));
    await tester.scrollUntilVisible(
      tile,
      100,
      scrollable: find
          .descendant(of: rail, matching: find.byType(Scrollable))
          .first,
    );
    await tester.tap(tile);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mở Flashcard'));
    await tester.pumpAndSettle();
    expect(find.byType(FlashcardDeckListScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
