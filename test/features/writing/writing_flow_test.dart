import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/bootstrap/bootstrap.dart';
import 'package:lingua/core/config/app_config.dart';
import 'package:lingua/core/config/app_environment.dart';

void main() {
  Future<void> openExercise(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(788, 1083));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      createAppRoot(
        config: const AppConfig(environment: AppEnvironment.production),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Writing').first);
    await tester.pumpAndSettle();
    expect(find.text('Choose a topic'), findsOneWidget);
    await tester.tap(find.text('Daily life'));
    await tester.pumpAndSettle();
    expect(find.text('Small steps'), findsOneWidget);
    await tester.tap(find.text('Start').first);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('writing-answer-input')), findsOneWidget);
  }

  testWidgets('Home to Writing flow, correct feedback, and Next progression', (
    tester,
  ) async {
    await openExercise(tester);
    final submit = find.byKey(const Key('writing-submit'));
    expect(find.bySemanticsLabel('Submit'), findsWidgets);
    expect(tester.widget<IconButton>(submit).onPressed, isNull);
    await tester.enterText(
      find.byKey(const Key('writing-answer-input')),
      'I practice English every morning.',
    );
    await tester.pump();
    expect(tester.widget<IconButton>(submit).onPressed, isNotNull);
    await tester.tap(submit);
    await tester.pump();
    expect(find.text('Grading…'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.byKey(const Key('feedback-correct')), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.liveRegion == true &&
            widget.properties.label == 'Excellent',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Next'));
    await tester.pump();
    expect(find.text('Sau đó, tôi uống một tách trà.'), findsOneWidget);
    expect(find.text('I practice English every morning.'), findsNothing);
  });

  testWidgets('incorrect answer shows the canonical incorrect variant', (
    tester,
  ) async {
    await openExercise(tester);
    await tester.enterText(
      find.byKey(const Key('writing-answer-input')),
      'Definitely wrong',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('writing-submit')));
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.byKey(const Key('feedback-incorrect')), findsOneWidget);
    expect(find.text('Not correct yet'), findsOneWidget);
  });
}
