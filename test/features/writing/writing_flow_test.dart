import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/bootstrap/bootstrap.dart';
import 'package:lingua/core/config/app_config.dart';
import 'package:lingua/core/config/app_environment.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

void main() {
  testWidgets('writing topic without lessons shows the canonical empty state', (
    tester,
  ) async {
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
    await tester.ensureVisible(find.text('Travel stories'));
    await tester.tap(find.text('Travel stories'));
    await tester.pumpAndSettle();
    expect(find.text('No lessons yet'), findsOneWidget);
  });

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
    expect(find.byKey(const Key('answer-input')), findsOneWidget);
    expect(find.byType(ExerciseTemplate), findsOneWidget);
  }

  testWidgets('Home to Writing flow, correct feedback, and Next progression', (
    tester,
  ) async {
    await openExercise(tester);
    final submit = find.byKey(const Key('submit-button'));
    expect(find.bySemanticsLabel('Submit'), findsWidgets);
    expect(tester.widget<IconButton>(submit).onPressed, isNull);
    await tester.enterText(
      find.byKey(const Key('answer-input')),
      'I practice English every morning.',
    );
    await tester.pump();
    expect(tester.widget<IconButton>(submit).onPressed, isNotNull);
    await tester.tap(submit);
    await tester.pump();
    expect(find.text('Grading…'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.byKey(const Key('feedback-correct')), findsOneWidget);
    expect(find.text('View AI analysis'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.liveRegion == true &&
            widget.properties.label == 'Correct',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('View AI analysis'));
    await tester.pump();
    expect(find.text('Grading…'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Excellent'), findsOneWidget);
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
      find.byKey(const Key('answer-input')),
      'Definitely wrong',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.byKey(const Key('feedback-incorrect')), findsOneWidget);
    expect(find.text('Not correct yet'), findsOneWidget);
  });

  testWidgets('final step shows completion and opens the next lesson', (
    tester,
  ) async {
    await openExercise(tester);
    for (final answer in [
      'I practice English every morning.',
      'Then I drink a cup of tea.',
      'I walk to work.',
    ]) {
      await tester.enterText(find.byKey(const Key('answer-input')), answer);
      await tester.pump();
      await tester.tap(find.byKey(const Key('submit-button')));
      await tester.pump(const Duration(milliseconds: 250));
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }
    expect(find.byType(CompletionTemplate), findsOneWidget);
    expect(find.text('Lesson complete'), findsOneWidget);
    expect(find.text('Steps completed'), findsOneWidget);
    expect(find.text('Corrections'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    await tester.tap(find.text('Next lesson'));
    await tester.pumpAndSettle();
    expect(find.byType(CompletionTemplate), findsNothing);
    expect(find.text('Cuối tuần này tôi sẽ thăm gia đình.'), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('answer-input')),
      'I will visit my family this weekend.',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pump(const Duration(milliseconds: 250));
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.byType(CompletionTemplate), findsOneWidget);
    final nextButton = tester.widget<FilledButton>(
      find.ancestor(
        of: find.text('Next lesson'),
        matching: find.byType(FilledButton),
      ),
    );
    expect(nextButton.onPressed, isNull);
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.byType(CompletionTemplate), findsNothing);
    expect(find.text('Small steps'), findsOneWidget);
  });
}
