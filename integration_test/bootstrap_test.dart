import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lingua/main_prod.dart' as app;
import 'package:lingua/app/localization/generated/app_localizations.dart';
import 'package:lingua/features/home/home.dart';
import 'package:lingua/core/preferences/locale_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('production entrypoint boots without external services', (
    tester,
  ) async {
    await app.main();
    await tester.pumpAndSettle();
    final page = find.byType(HomeDashboardScreen);
    expect(page, findsOneWidget);
    final strings = AppLocalizations.of(tester.element(page))!;
    expect(find.text(strings.homeGreeting), findsOneWidget);
    expect(find.text(strings.writing), findsOneWidget);
  });

  testWidgets('Grammar correct-answer smoke works without connectivity', (
    tester,
  ) async {
    await app.main();
    await tester.pumpAndSettle();
    final strings = AppLocalizations.of(
      tester.element(find.byType(HomeDashboardScreen)),
    )!;
    await tester.ensureVisible(find.text(strings.grammar).first);
    await tester.tap(find.text(strings.grammar).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Verb agreement'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(strings.grammarStart));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('answer-input')),
      'She works at the library every day.',
    );
    await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('submit-button')));
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('feedback-correct')), findsOneWidget);
    await tester.tap(find.text(strings.grammarNext));
    await tester.pumpAndSettle();
    expect(find.text('My brother play football on Sundays.'), findsOneWidget);
  });

  testWidgets('device locale store survives a fresh adapter instance', (
    tester,
  ) async {
    const testKey = 'integration_test.app.locale';
    final preferences = SharedPreferencesAsync();
    addTearDown(() => preferences.remove(testKey));
    final writer = SharedPreferencesLocaleStore(
      preferences: preferences,
      key: testKey,
    );
    await writer.save(const Locale('vi'));
    final reader = SharedPreferencesLocaleStore(key: testKey);
    expect((await reader.load())?.languageCode, 'vi');
  });
}
