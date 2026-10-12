import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/app.dart';
import 'package:lingua/app/localization/generated/app_localizations.dart';
import 'package:lingua_design_system/lingua_design_system.dart';
import 'package:lingua/features/grammar/presentation/providers/grammar_providers.dart';
import 'package:lingua/features/grammar/data/repositories/in_memory_grammar_repository.dart';
import 'package:lingua/features/grammar/domain/entities/grammar_content.dart';
import 'package:lingua/features/grammar/domain/repositories/grammar_repository.dart';

void main() {
  test('Grammar chrome is complete in English and Vietnamese', () {
    final localizedValues = <List<String>>[];
    for (final locale in const [Locale('en'), Locale('vi')]) {
      final strings = lookupAppLocalizations(locale);
      final values = [
        strings.grammarTopicsEyebrow,
        strings.grammarTopicsFirstLine,
        strings.grammarTopicsSecondLine,
        strings.grammarCategoryAll,
        strings.grammarCategoryFoundations,
        strings.grammarCategoryVerbs,
        strings.grammarLessonCount,
        strings.grammarLessonsEyebrow,
        strings.grammarLessonsFirstLine,
        strings.grammarLessonsSecondLine,
        strings.grammarStart,
        strings.grammarInstruction,
        strings.grammarSourceSentence,
        strings.grammarAnswerLabel,
        strings.grammarAnswerPlaceholder,
        strings.grammarSubmit,
        strings.grammarGrading,
        strings.grammarCancel,
        strings.grammarRetry,
        strings.grammarCorrectTitle,
        strings.grammarIncorrectTitle,
        strings.grammarCorrection,
        strings.grammarTips,
        strings.grammarFix,
        strings.grammarNext,
        strings.grammarStepOf,
        strings.grammarHint,
        strings.grammarShowFeedback,
        strings.grammarYourAnswer,
        strings.grammarViewAnalysis,
        strings.grammarAnalysisUnavailable,
        strings.grammarEmptyTopicsTitle,
        strings.grammarEmptyTopicsBody,
        strings.grammarEmptyLessonsTitle,
        strings.grammarEmptyLessonsBody,
        strings.grammarUnavailableTitle,
        strings.grammarUnavailableBody,
        strings.grammarErrorTitle,
        strings.grammarErrorBody,
        strings.grammarPager,
        strings.grammarPagerPosition(1, 2),
        strings.grammarMinimizeFeedback,
        strings.grammar,
        strings.back,
        strings.close,
      ];
      expect(values, everyElement(isNotEmpty));
      expect(values, everyElement(isNot(startsWith('grammar'))));
      expect(values, hasLength(45));
      localizedValues.add(values);
    }
    for (var index = 0; index < localizedValues.first.length; index++) {
      expect(
        localizedValues.first[index],
        isNot(localizedValues.last[index]),
        reason: 'Grammar chrome field $index must not fall back across EN/VI',
      );
    }
  });

  testWidgets('pager semantics are fully localized in English and Vietnamese', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);
    for (final locale in const [Locale('en'), Locale('vi')]) {
      final strings = lookupAppLocalizations(locale);
      tester.binding.platformDispatcher.localesTestValue = [locale];
      await tester.pumpWidget(
        ProviderScope(
          key: UniqueKey(),
          overrides: [
            grammarRepositoryProvider.overrideWithValue(_TwoLessonRepository()),
          ],
          child: const LinguaApp(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(const ValueKey('dashboard-pager-1')),
      );
      await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(strings.grammar));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Verb agreement'));
      await tester.pumpAndSettle();

      final pager = tester.getSemantics(
        find.byKey(const Key('lesson-pager-semantics')),
      );
      expect(pager.label, strings.grammarPager);
      expect(pager.value, strings.grammarPagerPosition(1, 2));
      expect(
        find.bySemanticsLabel(strings.grammarPagerPosition(2, 2)),
        findsOneWidget,
      );
      if (locale.languageCode == 'vi') {
        expect(
          '${pager.label} ${pager.value}'.toLowerCase(),
          isNot(contains('carousel')),
        );
        expect(
          '${pager.label} ${pager.value}'.toLowerCase(),
          isNot(contains(' of ')),
        );
      }
    }
    semantics.dispose();
  });

  testWidgets('Vietnamese chrome and English authored content adapt by width', (
    tester,
  ) async {
    tester.binding.platformDispatcher.localesTestValue = const [Locale('vi')];
    addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);
    addTearDown(() => tester.binding.setSurfaceSize(null));

    for (final width in [390.0, 788.0, 1200.0]) {
      await tester.binding.setSurfaceSize(Size(width, 900));
      await tester.pumpWidget(
        ProviderScope(key: UniqueKey(), child: const LinguaApp()),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(const ValueKey('dashboard-pager-1')),
      );
      await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Ngữ pháp'));
      await tester.pumpAndSettle();
      expect(find.text('LUYỆN NGỮ PHÁP'), findsOneWidget);
      expect(find.text('Verb agreement'), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('short height and large text keep Grammar browse scrollable', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 420));
    tester.binding.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(() => tester.binding.setSurfaceSize(null));
    addTearDown(
      tester.binding.platformDispatcher.clearTextScaleFactorTestValue,
    );
    await tester.pumpWidget(const ProviderScope(child: LinguaApp()));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Grammar'));
    await tester.pumpAndSettle();
    expect(find.byType(Scrollable), findsWidgets);
    expect(find.text('Verb agreement'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('full EN/VI journey is equivalent across canonical widths', (
    tester,
  ) async {
    addTearDown(() => tester.binding.setSurfaceSize(null));
    addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);
    for (final locale in const [Locale('en'), Locale('vi')]) {
      final strings = lookupAppLocalizations(locale);
      final other = lookupAppLocalizations(
        locale.languageCode == 'en' ? const Locale('vi') : const Locale('en'),
      );
      tester.binding.platformDispatcher.localesTestValue = [locale];
      for (final width in [390.0, 788.0, 1200.0]) {
        await tester.binding.setSurfaceSize(Size(width, 900));
        await tester.pumpWidget(
          ProviderScope(
            key: UniqueKey(),
            overrides: [
              grammarMinimumDwellProvider.overrideWithValue(Duration.zero),
            ],
            child: const LinguaApp(),
          ),
        );
        await tester.pumpAndSettle();
        await tester.ensureVisible(
          find.byKey(const ValueKey('dashboard-pager-1')),
        );
        await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
        await tester.pumpAndSettle();
        await tester.tap(find.text(strings.grammar));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Verb agreement'));
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text(strings.grammarStart));
        await tester.tap(find.text(strings.grammarStart));
        await tester.pumpAndSettle();
        expect(find.text(strings.grammarInstruction), findsOneWidget);
        expect(find.text(other.grammarInstruction), findsNothing);
        expect(find.text('She work at the library every day.'), findsOneWidget);

        await tester.enterText(
          find.byKey(const Key('answer-input')),
          'She work here.',
        );
        await tester.pump();
        await tester.ensureVisible(find.byKey(const Key('submit-button')));
        await tester.tap(find.byKey(const Key('submit-button')));
        await tester.pumpAndSettle();
        expect(find.text(strings.grammarIncorrectTitle), findsOneWidget);
        expect(
          find.bySemanticsLabel(
            'works, ${locale.languageCode == 'en' ? 'add' : 'thêm vào'}',
          ),
          findsOneWidget,
        );
        expect(find.byIcon(Icons.cancel_rounded), findsWidgets);
        await tester.tap(find.text(strings.grammarFix));
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
          'She works at the library every day.',
        );
        await tester.pump();
        await tester.ensureVisible(find.byKey(const Key('submit-button')));
        await tester.tap(find.byKey(const Key('submit-button')));
        await tester.pumpAndSettle();
        expect(find.text(strings.grammarCorrectTitle), findsOneWidget);
        expect(find.byIcon(Icons.check_circle_rounded), findsWidgets);
        expect(find.text(strings.grammarAnalysisUnavailable), findsOneWidget);
        expect(
          tester
              .widget<AppButton>(
                find.widgetWithText(AppButton, strings.grammarViewAnalysis),
              )
              .onPressed,
          isNull,
        );
        expect(
          find.bySemanticsLabel(strings.grammarMinimizeFeedback),
          findsOneWidget,
        );
        expect(find.bySemanticsLabel(strings.close), findsOneWidget);
        await tester.tap(
          find.bySemanticsLabel(strings.grammarMinimizeFeedback),
        );
        await tester.pump();
        expect(find.text(strings.grammarShowFeedback), findsOneWidget);
        expect(find.byType(FeedbackSheet), findsNothing);
        await tester.tap(find.text(strings.grammarShowFeedback));
        await tester.pump();
        expect(find.text(strings.grammarCorrectTitle), findsOneWidget);
        expect(
          find.bySemanticsLabel(strings.grammarMinimizeFeedback),
          findsOneWidget,
        );
        await tester.tap(find.text(strings.grammarNext));
        await tester.pump();
        expect(
          find.text('My brother play football on Sundays.'),
          findsOneWidget,
        );
        await tester.enterText(
          find.byKey(const Key('answer-input')),
          'My brother plays football on Sundays.',
        );
        await tester.pump();
        await tester.ensureVisible(find.byKey(const Key('submit-button')));
        await tester.tap(find.byKey(const Key('submit-button')));
        await tester.pumpAndSettle();
        expect(find.text(strings.grammarCorrectTitle), findsOneWidget);
        await tester.tap(find.text(strings.grammarNext));
        await tester.pumpAndSettle();
        expect(find.text('The dog chase birds in the park.'), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    }
  });

  testWidgets('200% text and short exercise keep feedback actions reachable', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 420));
    tester.binding.platformDispatcher.textScaleFactorTestValue = 2;
    tester.view.viewInsets = const FakeViewPadding(bottom: 180);
    addTearDown(() => tester.binding.setSurfaceSize(null));
    addTearDown(
      tester.binding.platformDispatcher.clearTextScaleFactorTestValue,
    );
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          grammarMinimumDwellProvider.overrideWithValue(Duration.zero),
        ],
        child: const LinguaApp(),
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
    await tester.ensureVisible(find.text('Verb agreement'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Verb agreement'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Start'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('answer-input')), 'wrong');
    await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('submit-button')));
    await tester.tap(find.byKey(const Key('submit-button')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Next'));
    expect(find.text('Fix'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('pointer, hover, and multi-control keyboard traversal work', (
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
    await tester.ensureVisible(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(mouse.removePointer);
    await mouse.addPointer();
    await mouse.moveTo(
      tester.getCenter(find.byKey(const ValueKey('mode-card-02'))),
    );
    await tester.pump();
    await mouse.down(
      tester.getCenter(find.byKey(const ValueKey('mode-card-02'))),
    );
    await mouse.up();
    await tester.pumpAndSettle();
    expect(find.text('Verb agreement'), findsOneWidget);
    await tester.tap(find.text('Verb agreement'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('answer-input')),
      'She works at the library every day.',
    );
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(find.bySemanticsLabel('Look at the subject.'), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(
      find.bySemanticsLabel('Check the present-tense verb.'),
      findsOneWidget,
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pumpAndSettle();
    expect(find.text('Correct'), findsOneWidget);
  });

  testWidgets(
    'lesson pager changes page by pointer and keyboard at all widths',
    (tester) async {
      addTearDown(() => tester.binding.setSurfaceSize(null));
      for (final width in [390.0, 788.0, 1200.0]) {
        await tester.binding.setSurfaceSize(Size(width, 900));
        await tester.pumpWidget(
          ProviderScope(
            key: UniqueKey(),
            overrides: [
              grammarRepositoryProvider.overrideWithValue(
                _TwoLessonRepository(),
              ),
            ],
            child: const LinguaApp(),
          ),
        );
        await tester.pumpAndSettle();
        await tester.ensureVisible(
          find.byKey(const ValueKey('dashboard-pager-1')),
        );
        await tester.tap(find.byKey(const ValueKey('dashboard-pager-1')));
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.byKey(const ValueKey('mode-card-02')));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Grammar'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Verb agreement'));
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(const ValueKey('lesson-pager-1')),
          kind: PointerDeviceKind.mouse,
        );
        await tester.pumpAndSettle();
        final selectedByPointer = tester.getSemantics(
          find.byKey(const Key('lesson-pager-semantics')),
        );
        expect(selectedByPointer.label, 'Lesson carousel');
        expect(selectedByPointer.value, 'Page 2 of 2');
        await tester.tap(find.byKey(const ValueKey('lesson-pager-0')));
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
        await tester.pumpAndSettle();
        final selectedByKeyboard = tester.getSemantics(
          find.byKey(const Key('lesson-pager-semantics')),
        );
        expect(selectedByKeyboard.label, 'Lesson carousel');
        expect(selectedByKeyboard.value, 'Page 2 of 2');
        expect(tester.takeException(), isNull);
      }
    },
  );

  test('canonical Grammar answer palette meets text contrast', () {
    final background = AnswerPaletteTokens.blue.background;
    final foreground = AnswerPaletteTokens.blue.foreground;
    final lighter = background.computeLuminance() + 0.05;
    final darker = foreground.computeLuminance() + 0.05;
    final ratio = lighter > darker ? lighter / darker : darker / lighter;
    expect(ratio, greaterThanOrEqualTo(4.5));
  });

  testWidgets('progress and submit expose semantics and target size', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: LinguaApp()));
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
    expect(find.bySemanticsLabel('Grammar progress'), findsOneWidget);
    final target = tester.getSize(find.byKey(const Key('submit-button')));
    expect(target.width, greaterThanOrEqualTo(ControlTokens.minTouchTarget));
    expect(target.height, greaterThanOrEqualTo(ControlTokens.minTouchTarget));
    expect(
      tester.widget<SubmitButton>(find.byType(SubmitButton)).onPressed,
      isNull,
    );
  });
}

class _TwoLessonRepository implements GrammarRepository {
  final _delegate = const InMemoryGrammarRepository();

  late final GrammarLesson _second = GrammarLesson(
    id: 'third-person-present-2',
    topicId: 'verb-agreement',
    level: 'A1',
    title: 'Agreement review',
    description: 'Review subject and verb agreement.',
    exercises: [
      GrammarSentenceExercise(
        id: 'agreement-review-1',
        incorrectSentence: 'He walk home.',
        acceptedAnswers: const ['He walks home.'],
        hints: const ['Check the subject.'],
        explanation: 'Use walks with he.',
        tips: const ['Match subject and verb.'],
      ),
    ],
  );

  @override
  List<String> get categoryIds => _delegate.categoryIds;
  @override
  List<GrammarTopic> get topics => _delegate.topics;
  @override
  List<GrammarLesson> lessonsForTopic(String topicId) =>
      topicId == 'verb-agreement'
      ? List.unmodifiable([
          _delegate.lessonById('third-person-present')!,
          _second,
        ])
      : _delegate.lessonsForTopic(topicId);
  @override
  GrammarTopic? topicById(String topicId) => _delegate.topicById(topicId);
  @override
  GrammarLesson? lessonById(String lessonId) =>
      lessonId == _second.id ? _second : _delegate.lessonById(lessonId);
  @override
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId) {
    final lesson = lessonById(lessonId);
    if (lesson == null) return null;
    for (final exercise in lesson.exercises) {
      if (exercise.id == exerciseId) return exercise;
    }
    return null;
  }

  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) => _delegate.grade(exercise: exercise, response: response);
}
