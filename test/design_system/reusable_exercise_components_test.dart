import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/design_system/components/app_button.dart';
import 'package:lingua/design_system/components/app_header.dart';
import 'package:lingua/design_system/components/browse_components.dart';
import 'package:lingua/design_system/components/exercise_components.dart';
import 'package:lingua/design_system/components/feedback_sheet.dart';
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
