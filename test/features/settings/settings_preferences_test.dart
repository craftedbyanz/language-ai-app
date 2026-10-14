import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/bootstrap/bootstrap.dart';
import 'package:lingua/core/config/app_config.dart';
import 'package:lingua/core/config/app_environment.dart';
import 'package:lingua/core/preferences/device_preferences.dart';

void main() {
  testWidgets('Profile lesson and appearance choices affect app surfaces', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final store = MemoryDevicePreferencesStore();
    await tester.pumpWidget(
      createAppRoot(
        config: const AppConfig(environment: AppEnvironment.production),
        deviceStore: store,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Profile'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Lesson settings'));
    await tester.tap(find.text('Lesson settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Blue'));
    await tester.pumpAndSettle();
    expect(store.value.answerPalette, LessonInputPalette.blue);
    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    expect(store.value.alwaysShowHints, isTrue);

    await tester.tap(find.byTooltip('Profile'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Appearance'));
    await tester.tap(find.text('Appearance'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mono'));
    await tester.pumpAndSettle();
    expect(store.value.cardStyle, 'mono');
  });
}
