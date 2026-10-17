import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hifive/app/bootstrap/bootstrap.dart';
import 'package:hifive/core/config/app_config.dart';
import 'package:hifive/core/config/app_environment.dart';
import 'package:hifive/core/preferences/device_preferences.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

class _FailingStore implements DevicePreferencesStore {
  int saves = 0;
  @override
  Future<DevicePreferences> load() async => const DevicePreferences();
  @override
  Future<void> save(DevicePreferences value) async {
    saves++;
    throw Exception('storage unavailable');
  }
}

Future<void> _selectLevel(WidgetTester tester, String label) async {
  await tester.tap(find.byKey(const Key('learning-language-level')));
  await tester.pumpAndSettle();
  await tester.ensureVisible(find.text(label));
  await tester.tap(find.text(label));
  await tester.tap(find.byKey(const Key('learning-level-confirm')));
  await tester.pumpAndSettle();
}

void main() {
  for (final width in [390.0, 788.0, 1200.0]) {
    testWidgets('Home language flow persists only on confirm at $width', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(Size(width, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final store = MemoryDevicePreferencesStore();
      await tester.pumpWidget(
        createAppRoot(
          config: const AppConfig(environment: AppEnvironment.production),
          initialLocale: const Locale('vi'),
          deviceStore: store,
        ),
      );
      await tester.pumpAndSettle();
      final flag = find.byType(LearningLanguageButton);
      expect(tester.getTopLeft(flag).dx, greaterThan(width / 2));
      await tester.tap(flag);
      await tester.pumpAndSettle();
      expect(find.text('Chọn ngôn ngữ học'), findsOneWidget);
      final tiles = tester
          .widgetList<LearningLanguageTile>(find.byType(LearningLanguageTile))
          .toList();
      expect(tiles.length, 4);
      expect(tiles.first.selected, isTrue);
      expect(
        tiles
            .skip(1)
            .every(
              (tile) => tile.onPressed == null && tile.comingSoonLabel != null,
            ),
        isTrue,
      );
      await _selectLevel(tester, 'B2 - Upper Intermediate');
      expect(store.value.learningLevel, LearningLevel.a1);
      await tester.tap(find.byKey(const Key('app-header-leading')));
      await tester.pumpAndSettle();
      await tester.tap(flag);
      await tester.pumpAndSettle();
      expect(find.text('A1 - Beginner'), findsOneWidget);
      await _selectLevel(tester, 'B2 - Upper Intermediate');
      await tester.tap(find.byKey(const Key('learning-language-confirm')));
      await tester.pumpAndSettle();
      expect(store.value.learningLevel, LearningLevel.b2);
      expect(find.text('Chào buổi sáng'), findsOneWidget);
      await tester.tap(find.byTooltip('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('B2'), findsOneWidget);
      await tester.tap(find.text('B2'));
      await tester.pumpAndSettle();
      expect(find.text('B2 - Upper Intermediate'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(
        createAppRoot(
          config: const AppConfig(environment: AppEnvironment.production),
          initialLocale: const Locale('vi'),
          initialDevicePreferences: await store.load(),
          deviceStore: store,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(LearningLanguageButton));
      await tester.pumpAndSettle();
      expect(find.text('B2 - Upper Intermediate'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('compact picker supports large text and keyboard activation', (
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
        deviceStore: MemoryDevicePreferencesStore(),
      ),
    );
    await tester.pumpAndSettle();
    // The new flag is the first interactive control in Home's reading order.
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.text('Choose your learning language'), findsOneWidget);
    await _selectLevel(tester, 'C2 - Proficient');
    await tester.tap(find.byKey(const Key('learning-language-confirm')));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('save failure stays on picker and rolls back without retries', (
    tester,
  ) async {
    final store = _FailingStore();
    await tester.pumpWidget(
      createAppRoot(
        config: const AppConfig(environment: AppEnvironment.production),
        deviceStore: store,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byType(LearningLanguageButton));
    await tester.pumpAndSettle();
    await _selectLevel(tester, 'B1 - Intermediate');
    await tester.tap(find.byKey(const Key('learning-language-confirm')));
    await tester.pumpAndSettle();
    expect(store.saves, 1);
    expect(find.byKey(const Key('learning-language-confirm')), findsOneWidget);
    final context = tester.element(
      find.byKey(const Key('learning-language-confirm')),
    );
    expect(
      ProviderScope.containerOf(context)
          .read(devicePreferencesProvider)
          .learningLevel,
      LearningLevel.a1,
    );
    expect(find.byType(SnackBar), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    expect(store.saves, 1);
    expect(tester.takeException(), isNull);
  });
  for (final width in [390.0, 788.0]) {
    testWidgets('learning-language visual baseline at $width', (tester) async {
      await tester.binding.setSurfaceSize(Size(width, 900));
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
          deviceStore: MemoryDevicePreferencesStore(),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byKey(const Key('home-greeting-row')),
        matchesGoldenFile('goldens/home_language_header_${width.toInt()}.png'),
      );
      await tester.tap(find.byType(LearningLanguageButton));
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppScaffold).last,
        matchesGoldenFile('goldens/learning_language_${width.toInt()}.png'),
      );
      await tester.tap(find.byKey(const Key('learning-language-level')));
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppScaffold).last,
        matchesGoldenFile('goldens/learning_level_${width.toInt()}.png'),
      );
      expect(tester.takeException(), isNull);
    });
  }
}
