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

      await tester.tap(find.byTooltip('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('A1'), findsOneWidget);
      expect(find.text('App language'), findsOneWidget);
      await tester.ensureVisible(find.text('App language'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('App language'));
      await tester.pumpAndSettle();
      expect(find.text('Tiếng Việt'), findsOneWidget);
      await tester.tap(find.text('Tiếng Việt'));
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Cài đặt chung'), findsOneWidget);
      expect(find.text('Ngôn ngữ ứng dụng'), findsOneWidget);
      await tester.ensureVisible(find.text('Lingua v0.1.0 (1)'));
      await tester.pumpAndSettle();
      expect(find.text('Khác'), findsOneWidget);
      expect(find.text('Đăng xuất'), findsOneWidget);
      expect(find.text('Học một chút mỗi ngày.'), findsOneWidget);
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
