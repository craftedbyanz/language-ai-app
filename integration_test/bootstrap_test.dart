import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lingua/main_prod.dart' as app;
import 'package:lingua/app/localization/generated/app_localizations.dart';
import 'package:lingua/features/home/home.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('production entrypoint boots without external services', (
    tester,
  ) async {
    app.main();
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
    app.main();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Grammar'));
    await tester.tap(find.text('Grammar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Verb agreement'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
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
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('My brother play football on Sundays.'), findsOneWidget);
  });
}
