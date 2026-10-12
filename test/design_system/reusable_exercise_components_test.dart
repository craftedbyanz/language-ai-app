import 'dart:ui' show PointerDeviceKind, SemanticsRole, Tristate;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/design_system/adaptive/window_size_class.dart';
import 'package:lingua/design_system/components/app_button.dart';
import 'package:lingua/design_system/components/app_header.dart';
import 'package:lingua/design_system/components/browse_components.dart';
import 'package:lingua/design_system/components/exercise_components.dart';
import 'package:lingua/design_system/components/feedback_sheet.dart';
import 'package:lingua/design_system/components/home_components.dart';
import 'package:lingua/design_system/patterns/exercise_template.dart';
import 'package:lingua/design_system/theme/app_theme.dart';
import 'package:lingua/design_system/tokens/generated/design_tokens.dart';

void main() {
  Future<void> pumpComponent(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(body: Center(child: child)),
      ),
    );
  }

  testWidgets('TopicCard uses the supplied canonical icon slot', (
    tester,
  ) async {
    await pumpComponent(
      tester,
      TopicCard(
        icon: Icons.school_outlined,
        title: 'Parts of speech',
        countLabel: '4 sets',
        onPressed: _noop,
      ),
    );
    expect(find.byIcon(Icons.school_outlined), findsOneWidget);
    expect(find.byIcon(Icons.edit_note_rounded), findsNothing);
  });

  testWidgets('LessonCard exposes Writing and Grammar canonical variants', (
    tester,
  ) async {
    await pumpComponent(
      tester,
      Row(
        children: [
          Expanded(
            child: LessonCard(
              variant: LessonCardVariant.writing,
              indexLabel: '01',
              level: 'A1',
              title: 'Writing',
              description: 'Translate a sentence.',
              actionLabel: 'Start',
              onPressed: _noop,
            ),
          ),
          Expanded(
            child: LessonCard(
              variant: LessonCardVariant.grammar,
              indexLabel: '02',
              level: 'A1',
              title: 'Grammar',
              description: 'Correct a sentence.',
              actionLabel: 'Quick fix',
              onPressed: _noop,
            ),
          ),
        ],
      ),
    );
    final buttons = tester
        .widgetList<AppButton>(find.byType(AppButton))
        .toList();
    expect(
      buttons.map((button) => button.variant),
      everyElement(AppButtonVariant.accent),
    );
    expect(buttons.map((button) => button.accent), [
      AppButtonAccent.writing,
      AppButtonAccent.grammar,
    ]);
  });

  testWidgets(
    'ProgressStepper maps Writing and Grammar variants to canonical tokens',
    (tester) async {
      final semantics = tester.ensureSemantics();
      Future<BoxDecoration> decorationFor(
        ProgressStepperVariant variant,
      ) async {
        await pumpComponent(
          tester,
          SizedBox(
            width: LayoutTokens.dialogWidth,
            child: ProgressStepper(
              variant: variant,
              step: 2,
              count: 3,
              semanticLabel: 'Step',
            ),
          ),
        );
        return tester
                .widget<Container>(
                  find.byKey(const ValueKey('progress-segment-0')),
                )
                .decoration
            as BoxDecoration;
      }

      expect(
        (await decorationFor(ProgressStepperVariant.writing)).color,
        FeatureTokens.writingProgress,
      );
      expect(
        (await decorationFor(ProgressStepperVariant.grammar)).color,
        FeatureTokens.grammarProgress,
      );
      final progress = tester.getSemantics(find.bySemanticsLabel('Step'));
      expect(progress.role, SemanticsRole.progressBar);
      expect(progress.flagsCollection.isLiveRegion, isTrue);
      semantics.dispose();
    },
  );

  testWidgets('AnswerInput keeps canonical purple and blue pairs together', (
    tester,
  ) async {
    final controller = TextEditingController(text: 'Answer');
    addTearDown(controller.dispose);

    Future<(Color?, Color?)> colorsFor(AnswerPaletteKey key) async {
      await pumpComponent(
        tester,
        AnswerInput(
          paletteKey: key,
          controller: controller,
          label: 'Your answer',
          placeholder: 'Type',
          onChanged: (_) {},
          enabled: true,
          autofocus: false,
        ),
      );
      final surface = tester.widget<Container>(
        find.byKey(const Key('answer-input-surface')),
      );
      final input = tester.widget<TextField>(
        find.byKey(const Key('answer-input')),
      );
      return ((surface.decoration! as BoxDecoration).color, input.style!.color);
    }

    expect(await colorsFor(AnswerPaletteKey.purple), (
      AnswerPaletteTokens.purple.background,
      AnswerPaletteTokens.purple.foreground,
    ));
    expect(await colorsFor(AnswerPaletteKey.blue), (
      AnswerPaletteTokens.blue.background,
      AnswerPaletteTokens.blue.foreground,
    ));
  });

  testWidgets('SourceTextCard supports Paragraph and Sentence presentation', (
    tester,
  ) async {
    await pumpComponent(
      tester,
      Column(
        children: const [
          SourceTextCard(
            variant: SourceTextCardVariant.paragraph,
            text: 'Paragraph source',
            semanticLabel: 'Source text',
          ),
          SourceTextCard(
            variant: SourceTextCardVariant.sentence,
            text: 'Sentence source',
            semanticLabel: 'Source text',
          ),
        ],
      ),
    );
    expect(
      tester.widget<Text>(find.text('Paragraph source')).style,
      TypographyTokens.body,
    );
    expect(
      tester.widget<Text>(find.text('Sentence source')).style,
      TypographyTokens.heading,
    );
  });

  testWidgets('Grammar additions preserve defaults and expose shared slots', (
    tester,
  ) async {
    final focusNode = FocusNode();
    final controller = TextEditingController();
    addTearDown(focusNode.dispose);
    addTearDown(controller.dispose);
    var feedbackRequested = false;
    await pumpComponent(
      tester,
      Column(
        children: [
          SectionHeader(
            eyebrow: 'Practice',
            firstLine: 'Choose',
            secondLine: 'Grammar',
            sizeClass: WindowSizeClass.compact,
            accent: SectionHeaderAccent.grammar,
          ),
          const SourceTextCard(
            variant: SourceTextCardVariant.sentence,
            text: 'She work here.',
            semanticLabel: 'Sentence',
            instruction: 'Correct the sentence.',
          ),
          AnswerInput(
            paletteKey: AnswerPaletteKey.blue,
            controller: controller,
            focusNode: focusNode,
            label: 'Answer',
            placeholder: 'Type',
            onChanged: (_) {},
            enabled: true,
            autofocus: false,
          ),
          HintChipBar(
            hints: const ['Look at the subject.'],
            hintLabel: (index) => 'Hint ${index + 1}',
            showFeedbackLabel: 'Show last feedback',
            onShowFeedback: () => feedbackRequested = true,
          ),
        ],
      ),
    );
    expect(find.text('Correct the sentence.'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField)).focusNode,
      focusNode,
    );
    focusNode.requestFocus();
    await tester.pump();
    expect(focusNode.hasFocus, isTrue);
    await tester.tap(find.text('Show last feedback'));
    expect(feedbackRequested, isTrue);
  });

  testWidgets('Empty state, pager and error recovery are reusable', (
    tester,
  ) async {
    var selected = -1;
    var retried = false;
    await pumpComponent(
      tester,
      Column(
        children: [
          PagerDots(
            count: 2,
            index: 0,
            semanticLabel: 'Lesson carousel',
            positionLabel: (current, total) => 'Page $current of $total',
            onSelected: (index) => selected = index,
          ),
          EmptyState(
            title: 'Could not load',
            body: 'Try again.',
            actionLabel: 'Retry',
            onAction: () => retried = true,
            error: true,
          ),
        ],
      ),
    );
    await tester.tap(find.byKey(const ValueKey('lesson-pager-1')));
    await tester.tap(find.text('Retry'));
    expect(selected, 1);
    expect(retried, isTrue);
    expect(find.bySemanticsLabel('Page 1 of 2'), findsOneWidget);
    final pagerTarget = tester.getSize(
      find.byKey(const ValueKey('lesson-pager-1')),
    );
    expect(
      pagerTarget.width,
      greaterThanOrEqualTo(ControlTokens.minTouchTarget),
    );
    expect(
      pagerTarget.height,
      greaterThanOrEqualTo(ControlTokens.minTouchTarget),
    );
    final pager = tester.getSemantics(
      find.byKey(const Key('lesson-pager-semantics')),
    );
    expect(pager.label, 'Lesson carousel');
    expect(pager.value, 'Page 1 of 2');
    expect(
      tester
          .getSemantics(find.bySemanticsLabel('Page 1 of 2'))
          .flagsCollection
          .isSelected,
      Tristate.isTrue,
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    expect(selected, 1);
    selected = -1;
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    expect(selected, isNot(-1));
  });

  testWidgets('InlineError is canonical, announced, and focuses Retry', (
    tester,
  ) async {
    final retryFocus = FocusNode(debugLabel: 'inline-error-retry');
    addTearDown(retryFocus.dispose);
    var retried = false;
    var cancelled = false;
    await pumpComponent(
      tester,
      InlineError(
        message: 'Could not grade the answer.',
        retryLabel: 'Retry',
        cancelLabel: 'Cancel',
        retryFocusNode: retryFocus,
        onRetry: () => retried = true,
        onCancel: () => cancelled = true,
      ),
    );

    expect(find.byKey(const Key('inline-error')), findsOneWidget);
    expect(
      find.bySemanticsLabel('Could not grade the answer.'),
      findsOneWidget,
    );
    await tester.pump();
    expect(retryFocus.hasFocus, isTrue);
    expect(
      tester.getSemantics(find.byKey(const Key('inline-error-alert'))).role,
      SemanticsRole.alert,
    );
    final message = tester.widget<Text>(
      find.text('Could not grade the answer.'),
    );
    final accessible = AppTheme.light()
        .extension<DesignTokensTheme>()!
        .accessible;
    expect(message.style!.color, accessible.errorText);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(retried, isTrue);
    await tester.tap(find.text('Cancel'));
    expect(cancelled, isTrue);
  });

  testWidgets('FeedbackSheet renders all exercise variants and loading', (
    tester,
  ) async {
    final variants = <FeedbackSheet>[
      FeedbackSheet.writingCorrect(
        title: 'Excellent',
        originalAnswer: 'Answer',
        correctedAnswer: 'Answer',
        explanation: 'Clear.',
        bullets: const ['Natural order'],
        sectionLabel: 'Improvements',
        correctionLabel: 'Correction',
        editLabel: 'Edit',
        nextLabel: 'Next',
        closeLabel: 'Close',
        minimizeLabel: 'Minimize feedback',
        onEdit: _noop,
        onNext: _noop,
        onClose: _noop,
      ),
      FeedbackSheet.writingIncorrect(
        title: 'Not correct',
        originalAnswer: 'Wrong',
        correctedAnswer: 'Right',
        explanation: 'Try again.',
        bullets: const ['Verb form'],
        sectionLabel: 'Improvements',
        correctionLabel: 'Correction',
        editLabel: 'Edit',
        nextLabel: 'Next',
        closeLabel: 'Close',
        onEdit: _noop,
        onNext: _noop,
        onClose: _noop,
      ),
      FeedbackSheet.grammarCorrect(
        title: 'Correct',
        answer: 'She works here.',
        recapLabel: 'Your answer',
        analysisLabel: 'View AI analysis',
        nextLabel: 'Next',
        closeLabel: 'Close',
        onAnalysis: _noop,
        onNext: _noop,
        onClose: _noop,
      ),
      FeedbackSheet.grammarIncorrect(
        title: 'Not correct',
        originalAnswer: 'She work here.',
        correctedAnswer: 'She works here.',
        explanation: 'Use third-person singular.',
        bullets: const ['Add s to the verb'],
        sectionLabel: 'Tips',
        correctionLabel: 'Correction',
        fixLabel: 'Fix',
        nextLabel: 'Next',
        closeLabel: 'Close',
        onFix: _noop,
        onNext: _noop,
        onClose: _noop,
      ),
    ];

    for (final sheet in variants) {
      await pumpComponent(tester, sheet);
      expect(find.byType(FeedbackSheet), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
    await pumpComponent(
      tester,
      FeedbackSheet.loading(
        gradingLabel: 'Grading',
        cancelLabel: 'Cancel',
        onCancel: _noop,
      ),
    );
    expect(find.text('Grading'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('Grammar feedback supports minimize and disabled analysis', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    final minimizeFocus = FocusNode(debugLabel: 'feedback-minimize');
    addTearDown(minimizeFocus.dispose);
    var minimizeCalls = 0;
    await pumpComponent(
      tester,
      FeedbackSheet.grammarCorrect(
        title: 'Correct',
        answer: 'She works here.',
        recapLabel: 'Your answer',
        analysisLabel: 'View AI analysis',
        analysisUnavailableReason: 'Unavailable offline',
        nextLabel: 'Next',
        closeLabel: 'Close',
        minimizeLabel: 'Minimize feedback',
        minimizeFocusNode: minimizeFocus,
        onAnalysis: null,
        onNext: _noop,
        onClose: _noop,
        onMinimize: () => minimizeCalls++,
      ),
    );
    expect(find.text('Unavailable offline'), findsOneWidget);
    expect(
      find.bySemanticsLabel(RegExp('View AI analysis.*Unavailable offline')),
      findsOneWidget,
    );
    expect(
      tester
          .widget<AppButton>(find.widgetWithText(AppButton, 'View AI analysis'))
          .onPressed,
      isNull,
    );
    expect(find.bySemanticsLabel('Close'), findsOneWidget);
    expect(find.bySemanticsLabel('Minimize feedback'), findsOneWidget);
    expect(find.bySemanticsLabel('keyboard arrow down'), findsNothing);
    await tester.tap(find.byKey(const Key('feedback-minimize')));
    expect(minimizeCalls, 1);
    minimizeFocus.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    expect(minimizeCalls, 3);
    semantics.dispose();
  });

  testWidgets('Grammar correction segments expose non-color cues and labels', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpComponent(
      tester,
      FeedbackSheet.grammarIncorrect(
        title: 'Not correct',
        originalAnswer: 'She work.',
        correctedAnswer: 'She works.',
        correctionSegments: const [
          CorrectionSegment(text: 'She', kind: CorrectionSegmentKind.retained),
          CorrectionSegment(text: 'work', kind: CorrectionSegmentKind.removed),
          CorrectionSegment(
            text: 'works',
            kind: CorrectionSegmentKind.inserted,
          ),
        ],
        retainedLabel: 'kept',
        removedLabel: 'remove',
        insertedLabel: 'add',
        explanation: 'Match subject and verb.',
        bullets: const ['Add s'],
        sectionLabel: 'Tips',
        correctionLabel: 'Correction',
        fixLabel: 'Fix',
        nextLabel: 'Next',
        closeLabel: 'Close',
        onFix: _noop,
        onNext: _noop,
        onClose: _noop,
      ),
    );

    expect(find.bySemanticsLabel('work, remove'), findsOneWidget);
    expect(find.bySemanticsLabel('works, add'), findsOneWidget);
    expect(
      tester.widget<Text>(find.text('work')).style!.decoration,
      TextDecoration.lineThrough,
    );
    expect(
      tester.widget<Text>(find.text('works')).style!.decoration,
      TextDecoration.underline,
    );
    semantics.dispose();
  });

  testWidgets('loading and verdict feedback are polite live regions', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpComponent(
      tester,
      FeedbackSheet.loading(
        gradingLabel: 'Grading',
        cancelLabel: 'Cancel',
        onCancel: _noop,
      ),
    );
    expect(
      tester
          .getSemantics(find.byKey(const Key('feedback-loading-live-region')))
          .flagsCollection
          .isLiveRegion,
      isTrue,
    );
    expect(
      tester
          .getSemantics(find.byKey(const Key('feedback-loading-live-region')))
          .role,
      SemanticsRole.dialog,
    );
    expect(
      tester
          .getSemantics(find.byKey(const Key('feedback-loading-live-region')))
          .label,
      'Grading',
    );
    await pumpComponent(
      tester,
      FeedbackSheet.grammarCorrect(
        title: 'Correct',
        answer: 'She works.',
        recapLabel: 'Your answer',
        analysisLabel: 'View analysis',
        analysisUnavailableReason: 'Unavailable',
        nextLabel: 'Next',
        closeLabel: 'Close',
        onAnalysis: null,
        onNext: _noop,
        onClose: _noop,
      ),
    );
    expect(
      tester
          .getSemantics(find.byKey(const Key('feedback-live-region')))
          .flagsCollection
          .isLiveRegion,
      isTrue,
    );
    expect(
      tester.getSemantics(find.byKey(const Key('feedback-live-region'))).role,
      SemanticsRole.dialog,
    );
    expect(
      tester.getSemantics(find.byKey(const Key('feedback-live-region'))).label,
      'Correct',
    );
    semantics.dispose();
  });

  testWidgets('keyboard focus uses the canonical token-backed ring', (
    tester,
  ) async {
    final previousStrategy = FocusManager.instance.highlightStrategy;
    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTraditional;
    addTearDown(() {
      FocusManager.instance.highlightStrategy = previousStrategy;
    });
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);
    await pumpComponent(
      tester,
      AppButton(label: 'Continue', onPressed: _noop, focusNode: focusNode),
    );
    focusNode.requestFocus();
    await tester.pump();
    final decoration =
        tester
                .widget<DecoratedBox>(
                  find.byKey(const Key('canonical-focus-ring')),
                )
                .decoration
            as BoxDecoration;
    final accessible = AppTheme.light()
        .extension<DesignTokensTheme>()!
        .accessible;
    expect(decoration.border!.top.color, accessible.focusRing);
    expect(decoration.border!.top.width, FocusTokens.ringWidth);

    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTouch;
    await tester.pump();
    expect(find.byKey(const Key('canonical-focus-ring')), findsNothing);

    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTraditional;
    await tester.pump();
    expect(find.byKey(const Key('canonical-focus-ring')), findsOneWidget);
  });

  testWidgets('shared card, header, and feedback controls use focus rings', (
    tester,
  ) async {
    final previousStrategy = FocusManager.instance.highlightStrategy;
    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTraditional;
    addTearDown(() {
      FocusManager.instance.highlightStrategy = previousStrategy;
    });
    final modeFocus = FocusNode(debugLabel: 'mode-card');
    final headerFocus = FocusNode(debugLabel: 'app-header');
    final minimizeFocus = FocusNode(debugLabel: 'feedback-minimize');
    final closeFocus = FocusNode(debugLabel: 'feedback-close');
    addTearDown(modeFocus.dispose);
    addTearDown(headerFocus.dispose);
    addTearDown(minimizeFocus.dispose);
    addTearDown(closeFocus.dispose);

    await pumpComponent(
      tester,
      SizedBox(
        width: LayoutTokens.contentMaxWidth,
        height: 700,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: LayoutTokens.modeCardMinHeight,
                child: ModeCard(
                  index: '02',
                  category: 'Learning modes',
                  title: 'Grammar',
                  description: 'Practice grammar.',
                  actionLabel: 'Explore',
                  fill: FeatureTokens.grammarHomeCardFill,
                  foreground: ColorTokens.textPrimary,
                  focusNode: modeFocus,
                  onPressed: _noop,
                ),
              ),
              AppHeader(
                variant: AppHeaderVariant.pushed,
                title: 'Grammar',
                leadingLabel: 'Back',
                leadingFocusNode: headerFocus,
                onLeadingPressed: _noop,
              ),
              FeedbackSheet.grammarCorrect(
                title: 'Correct',
                answer: 'She works.',
                recapLabel: 'Your answer',
                analysisLabel: 'View analysis',
                analysisUnavailableReason: 'Unavailable',
                nextLabel: 'Next',
                closeLabel: 'Close',
                minimizeLabel: 'Minimize feedback',
                minimizeFocusNode: minimizeFocus,
                closeFocusNode: closeFocus,
                onAnalysis: null,
                onNext: _noop,
                onClose: _noop,
                onMinimize: _noop,
              ),
            ],
          ),
        ),
      ),
    );

    for (final node in [modeFocus, headerFocus, minimizeFocus, closeFocus]) {
      node.requestFocus();
      await tester.pump();
      expect(node.hasFocus, isTrue);
      expect(find.byKey(const Key('canonical-focus-ring')), findsOneWidget);
    }
  });

  testWidgets('ModeCard exposes hover state and remains pointer actionable', (
    tester,
  ) async {
    final states = WidgetStatesController();
    addTearDown(states.dispose);
    var activations = 0;
    await pumpComponent(
      tester,
      SizedBox(
        width: LayoutTokens.contentMaxWidth,
        height: LayoutTokens.modeCardMinHeight,
        child: ModeCard(
          index: '02',
          category: 'Learning modes',
          title: 'Grammar',
          description: 'Practice grammar.',
          actionLabel: 'Explore',
          fill: FeatureTokens.grammarHomeCardFill,
          foreground: ColorTokens.textPrimary,
          statesController: states,
          onPressed: () => activations++,
        ),
      ),
    );
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(mouse.removePointer);
    await mouse.addPointer();
    await mouse.moveTo(
      tester.getCenter(find.byKey(const ValueKey('mode-card-02'))),
    );
    await tester.pump();
    expect(states.value, contains(WidgetState.hovered));
    expect(activations, 0);
    await mouse.down(
      tester.getCenter(find.byKey(const ValueKey('mode-card-02'))),
    );
    await mouse.up();
    await tester.pump();
    expect(activations, 1);
  });

  testWidgets('disabled actions are skipped by keyboard traversal', (
    tester,
  ) async {
    final closeFocus = FocusNode(debugLabel: 'feedback-close');
    addTearDown(closeFocus.dispose);
    var nextCalls = 0;
    await pumpComponent(
      tester,
      FeedbackSheet.grammarCorrect(
        title: 'Correct',
        answer: 'She works.',
        recapLabel: 'Your answer',
        analysisLabel: 'View analysis',
        analysisUnavailableReason: 'Unavailable',
        nextLabel: 'Next',
        closeLabel: 'Close',
        closeFocusNode: closeFocus,
        onAnalysis: null,
        onNext: () => nextCalls++,
        onClose: _noop,
      ),
    );
    closeFocus.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(nextCalls, 1);
  });

  testWidgets('disabled Submit is excluded from Tab traversal', (tester) async {
    final beforeFocus = FocusNode(debugLabel: 'before-submit');
    final submitFocus = FocusNode(debugLabel: 'disabled-submit');
    final afterFocus = FocusNode(debugLabel: 'after-submit');
    addTearDown(beforeFocus.dispose);
    addTearDown(submitFocus.dispose);
    addTearDown(afterFocus.dispose);
    await pumpComponent(
      tester,
      Row(
        children: [
          AppButton(label: 'Before', onPressed: _noop, focusNode: beforeFocus),
          SubmitButton(
            label: 'Submit',
            onPressed: null,
            loading: false,
            focusNode: submitFocus,
          ),
          AppButton(label: 'After', onPressed: _noop, focusNode: afterFocus),
        ],
      ),
    );
    beforeFocus.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(submitFocus.hasFocus, isFalse);
    expect(afterFocus.hasFocus, isTrue);
  });

  testWidgets('ExerciseTemplate renders independently of feature providers', (
    tester,
  ) async {
    await pumpComponent(
      tester,
      ExerciseTemplate(
        leadingLabel: 'Close',
        onClose: _noop,
        progress: const Text('Progress slot'),
        source: const Text('Source slot'),
        answer: const Text('Answer slot'),
        hints: const Text('Hints slot'),
        submit: const Text('Submit slot'),
        feedback: const Text('Feedback slot'),
      ),
    );
    for (final label in [
      'Progress slot',
      'Source slot',
      'Answer slot',
      'Hints slot',
      'Submit slot',
      'Feedback slot',
    ]) {
      expect(find.text(label), findsOneWidget);
    }
  });
}

void _noop() {}
