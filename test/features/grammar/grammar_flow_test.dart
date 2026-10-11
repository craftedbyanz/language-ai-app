import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/app.dart';
import 'package:lingua/app/router/app_router.dart';
import 'package:lingua/app/router/app_routes.dart';
import 'package:lingua/design_system/components/app_button.dart';
import 'package:lingua/design_system/components/exercise_components.dart';
import 'package:lingua/design_system/components/feedback_sheet.dart';
import 'package:lingua/features/grammar/data/repositories/in_memory_grammar_repository.dart';
import 'package:lingua/features/grammar/domain/entities/grammar_content.dart';
import 'package:lingua/features/grammar/domain/repositories/grammar_repository.dart';
import 'package:lingua/features/grammar/presentation/providers/grammar_providers.dart';

void main() {
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
        child: const LinguaApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Grammar'));
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
    expect(find.text('Third-person present'), findsOneWidget);
    await tester.ensureVisible(find.text('Start'));
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(find.text('She work at the library every day.'), findsOneWidget);
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
        child: const LinguaApp(),
      ),
    );
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
    await tester.pumpWidget(const ProviderScope(child: LinguaApp()));
    await tester.pumpAndSettle();
    final context = tester.element(find.byType(LinguaApp));
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
        child: const LinguaApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Grammar'));
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
        child: const LinguaApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Grammar'));
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
        child: const LinguaApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Grammar'));
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
        child: const LinguaApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Grammar'));
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
        child: const LinguaApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Grammar'));
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
        child: const LinguaApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Grammar'));
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
        child: const LinguaApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Grammar'));
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
          .widget<Focus>(find.byKey(const Key('section-heading-focus')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
  });

  testWidgets('incorrect verdict on final sentence returns to lesson list', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          grammarMinimumDwellProvider.overrideWithValue(Duration.zero),
        ],
        child: const LinguaApp(),
      ),
    );
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

    expect(find.text('Third-person present'), findsOneWidget);
    expect(
      tester
          .widget<Focus>(find.byKey(const Key('section-heading-focus')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
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
