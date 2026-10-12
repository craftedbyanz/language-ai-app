import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/bootstrap/bootstrap.dart';
import 'package:lingua/core/config/app_config.dart';
import 'package:lingua/core/config/app_environment.dart';
import 'package:lingua/core/preferences/locale_preference.dart';

void main() {
  for (final width in [390.0, 788.0, 1200.0]) {
    testWidgets('Settings language choice updates app at width $width', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(Size(width, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final localeStore = MemoryLocaleStore();
      await tester.pumpWidget(
        createAppRoot(
          config: const AppConfig(environment: AppEnvironment.production),
          localeStore: localeStore,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Settings'));
      await tester.pumpAndSettle();
      expect(find.text('Language'), findsOneWidget);
      await tester.tap(find.text('Language'));
      await tester.pumpAndSettle();
      expect(find.text('Tiếng Việt'), findsOneWidget);
      await tester.tap(find.text('Tiếng Việt'));
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      expect(find.text('Cài đặt'), findsWidgets);
      expect(find.text('Ngôn ngữ'), findsOneWidget);
      expect((await localeStore.load())?.languageCode, 'vi');
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpWidget(
        createAppRoot(
          config: const AppConfig(environment: AppEnvironment.production),
          initialLocale: await localeStore.load(),
          localeStore: localeStore,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Chào buổi sáng'), findsOneWidget);
    });
  }
}
