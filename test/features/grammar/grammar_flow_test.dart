import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hifive/app/app.dart';
import 'package:hifive/app/router/app_router.dart';
import 'package:hifive/app/router/app_routes.dart';
import 'package:lingua_design_system/lingua_design_system.dart';
import 'package:hifive/features/grammar/data/repositories/in_memory_grammar_repository.dart';
import 'package:hifive/features/grammar/domain/entities/grammar_content.dart';
import 'package:hifive/features/grammar/domain/repositories/grammar_repository.dart';
import 'package:hifive/features/grammar/presentation/providers/grammar_providers.dart';
import 'package:hifive/features/grammar/presentation/state/grammar_exercise_state.dart';

void main() {
  testWidgets('grammar completion floats over lesson list at compact width', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          grammarRepositoryProvider.overrideWithValue(
            _OneStepGrammarRepository(),
          ),
          grammarMinimumDwellProvider.overrideWithValue(Duration.zero),
        ],
        child: const HiFiveApp(),
      ),
    );
    await tester.pumpAndSettle();
    final context = tester.element(find.byType(HiFiveApp));
    final router = ProviderScope.containerOf(context).read(appRouterProvider);
    router.go(
      const GrammarExerciseRoute(
        topicId: 'verb-agreement',
        lessonId: 'third-person-present',
      ).location,
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('answer-input')),
      'She works at the library every day.',
    );
    await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('submit-button')));
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.byType(CompletionTemplate), findsOneWidget);
    expect(find.text('Lesson complete'), findsOneWidget);
    expect(find.text('Steps completed'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.byType(CompletionTemplate), findsNothing);
    expect(find.text('Third-person present'), findsOneWidget);
  });

  test('final grammar step retains completion totals', () async {
    final container = ProviderContainer(
      overrides: [grammarMinimumDwellProvider.overrideWithValue(Duration.zero)],
    );
    addTearDown(container.dispose);
    const args = GrammarWorkflowArgs(
      topicId: 'verb-agreement',
      lessonId: 'third-person-present',
    );
    final subscription = container.listen(
      grammarExerciseViewModelProvider(args),
      (_, _) {},
    );
    addTearDown(subscription.close);
    final notifier = container.read(
      grammarExerciseViewModelProvider(args).notifier,
    );
    final lesson = container
        .read(grammarRepositoryProvider)
        .lessonById(args.lessonId)!;
    notifier.answerChanged('wrong');
    await notifier.submit();
    expect(
      container.read(grammarExerciseViewModelProvider(args)),
      isA<GrammarFeedbackIncorrect>(),
    );
    notifier.fix();
    for (final exercise in lesson.exercises) {
      notifier.answerChanged(exercise.acceptedAnswers.first);
      await notifier.submit();
      expect(
        container.read(grammarExerciseViewModelProvider(args)),
        isA<GrammarFeedbackCorrect>(),
      );
      notifier.next();
    }
    final finished = container.read(grammarExerciseViewModelProvider(args));
    expect(finished, isA<GrammarFinished>());
    expect(
      (finished as GrammarFinished).stepsCompleted,
      lesson.exercises.length,
    );
    expect(finished.corrections, 1);
  });

  testWidgets('Home to Grammar correct feedback and next sentence', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          grammarMinimumDwellProvider.overrideWithValue(
            const Duration(milliseconds: 300),
          ),
        ],
        child: const HiFiveApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Grammar'));
    await tester.pumpAndSettle();
    expect(find.text('Verb agreement'), findsOneWidget);

    await tester.tap(find.text('Verb agreement'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('lesson-pager-0')), findsOneWidget);

    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    final answerSurface = tester.widget<Container>(
      find.byKey(const Key('answer-input-surface')),
    );
    expect(answerSurface.decoration, isNotNull);
    final submit = tester.widget<SubmitButton>(find.byType(SubmitButton));
    expect(submit.onPressed, isNull);

    await tester.enterText(
      find.byKey(const Key('answer-input')),
      'She works at the library every day.',
    );
    await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('submit-button')));
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pump();
    expect(find.text('Grading…'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pump();
    expect(find.text('Grading…'), findsNothing);
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('answer-input')))
          .controller!
          .text,
      'She works at the library every day.',
    );
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pump();
    expect(find.text('Grading…'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 299));
    expect(find.text('Grading…'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump();
    expect(find.byKey(const Key('feedback-correct')), findsOneWidget);
    expect(
      find.text('AI analysis is unavailable in this local practice.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('My brother play football on Sundays.'), findsOneWidget);
    expect(find.byType(FeedbackSheet), findsNothing);

    await tester.enterText(
      find.byKey(const Key('answer-input')),
      'My brother plays football on Sundays.',
    );
    await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('submit-button')));
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('The dog chase birds in the park.'), findsOneWidget);
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('answer-input')))
          .controller!
          .text,
      isEmpty,
    );
  });

  testWidgets('incorrect feedback can minimize, reopen, and fix', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          grammarMinimumDwellProvider.overrideWithValue(Duration.zero),
        ],
        child: const HiFiveApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Grammar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Verb agreement'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('answer-input')),
      'She work here.',
    );
    await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('submit-button')));
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('feedback-incorrect')), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pump();
    expect(find.text('Show last feedback'), findsOneWidget);
    await tester.tap(find.text('Show last feedback'));
    await tester.pump();
    await tester.tap(find.text('Fix'));
    await tester.pump();
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('answer-input')))
          .controller!
          .text,
      'She work here.',
    );
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('answer-input')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
    await tester.ensureVisible(find.byKey(const Key('submit-button')));
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('My brother play football on Sundays.'), findsOneWidget);
  });

  testWidgets('unknown identities show unavailable state with safe Back', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: HiFiveApp()));
    await tester.pumpAndSettle();
    final context = tester.element(find.byType(HiFiveApp));
    final router = ProviderScope.containerOf(context).read(appRouterProvider);
    router.go(const GrammarLessonRoute(topicId: 'missing').location);
    await tester.pumpAndSettle();
    expect(find.text('Grammar content unavailable'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Verb agreement'), findsOneWidget);

    router.go(
      const GrammarExerciseRoute(
        topicId: 'verb-tenses',
        lessonId: 'third-person-present',
      ).location,
    );
    await tester.pumpAndSettle();
    expect(find.text('Grammar content unavailable'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Simple past'), findsOneWidget);

    router.go(
      const GrammarExerciseRoute(
        topicId: 'verb-agreement',
        lessonId: 'missing',
      ).location,
    );
    await tester.pumpAndSettle();
    expect(find.text('Grammar content unavailable'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Third-person present'), findsOneWidget);
  });

  testWidgets('empty catalog and grading failure expose recovery UI', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          grammarRepositoryProvider.overrideWithValue(_EmptyRepository()),
        ],
        child: const HiFiveApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Grammar'));
    await tester.pumpAndSettle();
    expect(find.text('No grammar topics'), findsOneWidget);

    await tester.pumpWidget(
      ProviderScope(
        key: UniqueKey(),
        overrides: [
          grammarRepositoryProvider.overrideWithValue(
            _ThrowingGradeRepository(),
          ),
          grammarMinimumDwellProvider.overrideWithValue(Duration.zero),
        ],
        child: const HiFiveApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Grammar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Verb agreement'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('answer-input')), 'keep me');
    await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('submit-button')));
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('inline-error')), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(
      tester
          .widget<AppButton>(find.byKey(const Key('inline-error-retry')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('answer-input')))
          .controller!
          .text,
      'keep me',
    );
  });

  testWidgets('catalog failures stay regional with Retry and safe Back', (
    tester,
  ) async {
    final topicRepository = _ThrowingCatalogRepository(throwTopicsOnce: true);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          grammarRepositoryProvider.overrideWithValue(topicRepository),
        ],
        child: const HiFiveApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Grammar'));
    await tester.pumpAndSettle();
    expect(find.text('Grammar'), findsOneWidget);
    expect(find.text('Could not load grammar practice'), findsOneWidget);
    expect(find.byTooltip('Back'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Verb agreement'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Learning modes'), findsWidgets);

    final lessonRepository = _ThrowingCatalogRepository(throwLessonsOnce: true);
    await tester.pumpWidget(
      ProviderScope(
        key: UniqueKey(),
        overrides: [
          grammarRepositoryProvider.overrideWithValue(lessonRepository),
        ],
        child: const HiFiveApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Grammar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Verb agreement'));
    await tester.pumpAndSettle();
    expect(find.text('Grammar'), findsOneWidget);
    expect(find.text('Could not load grammar practice'), findsOneWidget);
    expect(find.byTooltip('Back'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Third-person present'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Verb agreement'), findsOneWidget);
  });

  testWidgets('exercise initialization failure retries and backs safely', (
    tester,
  ) async {
    final repository = _ThrowingCatalogRepository(throwExercisesOnce: true);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [grammarRepositoryProvider.overrideWithValue(repository)],
        child: const HiFiveApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Grammar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Verb agreement'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(find.text('Could not load grammar practice'), findsOneWidget);
    expect(find.byKey(const Key('inline-error-alert')), findsOneWidget);
    expect(
      tester
          .widget<AppButton>(find.byKey(const Key('inline-error-retry')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
    expect(repository.gradeCalls, 0);
    repository.throwExercisesOnce = false;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('She work at the library every day.'), findsOneWidget);
    expect(repository.gradeCalls, 0);

    final backRepository = _ThrowingCatalogRepository(throwExercisesOnce: true);
    await tester.pumpWidget(
      ProviderScope(
        key: UniqueKey(),
        overrides: [
          grammarRepositoryProvider.overrideWithValue(backRepository),
        ],
        child: const HiFiveApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Grammar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Verb agreement'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Third-person present'), findsOneWidget);
    expect(backRepository.gradeCalls, 0);
  });

  testWidgets('focus follows loading, recovery, feedback, and final return', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          grammarMinimumDwellProvider.overrideWithValue(Duration.zero),
        ],
        child: const HiFiveApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Grammar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Verb agreement'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('answer-input')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
    await tester.enterText(
      find.byKey(const Key('answer-input')),
      'She works at the library every day.',
    );
    await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('submit-button')));
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pump();
    expect(
      tester
          .widget<Focus>(find.byKey(const Key('feedback-loading-title-focus')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
    await tester.tap(find.text('Cancel'));
    await tester.pump();
    final submit = tester.widget<SubmitButton>(find.byType(SubmitButton));
    expect(submit.focusNode!.hasFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<Focus>(find.byKey(const Key('feedback-title-focus')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
    await tester.tap(find.byIcon(Icons.close_rounded).last);
    await tester.pump();
    expect(submit.focusNode!.hasFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<Focus>(find.byKey(const Key('feedback-title-focus')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pump();
    final feedbackChip = tester.widget<ActionChip>(
      find.byKey(const Key('show-last-feedback')),
    );
    expect(feedbackChip.focusNode!.hasFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(
      tester
          .widget<Focus>(find.byKey(const Key('feedback-title-focus')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pump();
    expect(feedbackChip.focusNode!.hasFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    await tester.tap(find.text('Next'));
    await tester.pump();
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('answer-input')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
    await tester.enterText(
      find.byKey(const Key('answer-input')),
      'My brother plays football on Sundays.',
    );
    await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('submit-button')));
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('answer-input')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
  });

  testWidgets('incorrect verdict advances to the next authored sentence', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          grammarMinimumDwellProvider.overrideWithValue(Duration.zero),
        ],
        child: const HiFiveApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
    await tester.pumpAndSettle();
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
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pump();
    await tester.enterText(find.byKey(const Key('answer-input')), 'wrong');
    await tester.pump();
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pumpAndSettle();
    expect(find.text('Not correct yet'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('The dog chase birds in the park.'), findsOneWidget);
    expect(find.byType(FeedbackSheet), findsNothing);
  });
}

class _EmptyRepository implements GrammarRepository {
  @override
  List<String> get categoryIds => const ['all'];
  @override
  List<GrammarTopic> get topics => const [];
  @override
  List<GrammarLesson> lessonsForTopic(String topicId) => const [];
  @override
  GrammarTopic? topicById(String topicId) => null;
  @override
  GrammarLesson? lessonById(String lessonId) => null;
  @override
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId) =>
      null;
  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) => throw UnimplementedError();
}

class _ThrowingGradeRepository implements GrammarRepository {
  final _delegate = const InMemoryGrammarRepository();
  @override
  List<String> get categoryIds => _delegate.categoryIds;
  @override
  List<GrammarTopic> get topics => _delegate.topics;
  @override
  List<GrammarLesson> lessonsForTopic(String topicId) =>
      _delegate.lessonsForTopic(topicId);
  @override
  GrammarTopic? topicById(String topicId) => _delegate.topicById(topicId);
  @override
  GrammarLesson? lessonById(String lessonId) => _delegate.lessonById(lessonId);
  @override
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId) =>
      _delegate.exerciseById(lessonId, exerciseId);
  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) async => throw StateError('offline');
}

class _ThrowingCatalogRepository implements GrammarRepository {
  _ThrowingCatalogRepository({
    this.throwTopicsOnce = false,
    this.throwLessonsOnce = false,
    this.throwExercisesOnce = false,
  });

  final _delegate = const InMemoryGrammarRepository();
  bool throwTopicsOnce;
  bool throwLessonsOnce;
  bool throwExercisesOnce;
  var gradeCalls = 0;

  @override
  List<String> get categoryIds => _delegate.categoryIds;
  @override
  List<GrammarTopic> get topics {
    if (throwTopicsOnce) {
      throwTopicsOnce = false;
      throw StateError('catalog unavailable');
    }
    return _delegate.topics;
  }

  @override
  List<GrammarLesson> lessonsForTopic(String topicId) {
    if (throwLessonsOnce) {
      throwLessonsOnce = false;
      throw StateError('catalog unavailable');
    }
    return _delegate.lessonsForTopic(topicId);
  }

  @override
  GrammarTopic? topicById(String topicId) => _delegate.topicById(topicId);
  @override
  GrammarLesson? lessonById(String lessonId) => _delegate.lessonById(lessonId);
  @override
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId) {
    if (throwExercisesOnce) {
      throw StateError('catalog unavailable');
    }
    return _delegate.exerciseById(lessonId, exerciseId);
  }

  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) {
    gradeCalls++;
    return _delegate.grade(exercise: exercise, response: response);
  }
}

class _OneStepGrammarRepository implements GrammarRepository {
  final _delegate = const InMemoryGrammarRepository();

  late final GrammarLesson _lesson = () {
    final original = _delegate.lessonById('third-person-present')!;
    return GrammarLesson(
      id: original.id,
      topicId: original.topicId,
      level: original.level,
      title: original.title,
      description: original.description,
      illustrationKey: original.illustrationKey,
      exercises: [original.exercises.first],
    );
  }();

  @override
  List<String> get categoryIds => _delegate.categoryIds;
  @override
  List<GrammarTopic> get topics => _delegate.topics;
  @override
  List<GrammarLesson> lessonsForTopic(String topicId) =>
      topicId == _lesson.topicId
      ? [_lesson]
      : _delegate.lessonsForTopic(topicId);
  @override
  GrammarTopic? topicById(String topicId) => _delegate.topicById(topicId);
  @override
  GrammarLesson? lessonById(String lessonId) =>
      lessonId == _lesson.id ? _lesson : _delegate.lessonById(lessonId);
  @override
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId) =>
      _delegate.exerciseById(lessonId, exerciseId);
  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) => _delegate.grade(exercise: exercise, response: response);
}
