import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/bootstrap/bootstrap.dart';
import 'package:lingua/core/config/app_config.dart';
import 'package:lingua/core/config/app_environment.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

void main() {
  for (final variant in [(390.0, 1.0), (788.0, 1.0), (390.0, 2.0)]) {
    final (width, scale) = variant;
    testWidgets('Profile artwork and typography at $width / $scale', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(Size(width, 1083));
      tester.binding.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(() => tester.binding.setSurfaceSize(null));
      addTearDown(
        tester.binding.platformDispatcher.clearTextScaleFactorTestValue,
      );
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
      await tester.tap(find.byTooltip('Profile'));
      await tester.pumpAndSettle();
      await tester.runAsync(() async {
        final context = tester.element(find.byType(ProfileIdentity));
        for (final image in tester.widgetList<Image>(find.byType(Image))) {
          await precacheImage(image.image, context);
        }
      });
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(
        tester.getSize(find.byKey(const Key('profile-avatar'))),
        Size.square(LayoutTokens.profileAvatar),
      );
      expect(find.byType(ProfileSettingIcon), findsNWidgets(14));
      final rowLabel = tester.widget<Text>(find.text('Chỉnh sửa hồ sơ'));
      expect(rowLabel.style, TypographyTokens.profileRow);
      for (final image in tester.widgetList<RawImage>(find.byType(RawImage))) {
        expect(image.image, isNotNull);
      }
      await expectLater(
        find.byType(AppScaffold),
        matchesGoldenFile(
          'goldens/profile_${width.toInt()}_${scale.toInt()}x.png',
        ),
      );
      await tester.ensureVisible(find.text('Đăng xuất'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
