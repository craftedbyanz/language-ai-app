import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

void main() {
  testWidgets('topic card and writing feedback variants', (tester) async {
    await tester.binding.setSurfaceSize(const Size(788, 720));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light().copyWith(platform: TargetPlatform.android),
        home: Scaffold(
          body: RepaintBoundary(
            key: const ValueKey('golden'),
            child: Padding(
              padding: const EdgeInsets.all(SpaceTokens.xl),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: LayoutTokens.topicCardHeight * 2,
                    height: LayoutTokens.topicCardHeight,
                    child: TopicCard(
                      icon: Icons.edit_note_rounded,
                      title: 'Daily life',
                      countLabel: '2 sets',
                      onPressed: _noop,
                    ),
                  ),
                  const SizedBox(width: SpaceTokens.xl),
                  Expanded(
                    child: FeedbackSheet.writingIncorrect(
                      title: 'Not correct yet',
                      correctedAnswer: 'I practice English every morning.',
                      originalAnswer: 'I practicing English.',
                      explanation:
                          'Use the simple present for a repeated daily habit.',
                      bullets: const [
                        'Check the verb form',
                        'Keep the time phrase together',
                      ],
                      correctionLabel: 'Correction',
                      sectionLabel: 'Key improvements',
                      editLabel: 'Edit',
                      nextLabel: 'Next',
                      closeLabel: 'Close',
                      onEdit: _noop,
                      onNext: _noop,
                      onClose: _noop,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await expectLater(
      find.byKey(const ValueKey('golden')),
      matchesGoldenFile('goldens/vertical_slice_components.png'),
    );
  });

  testWidgets('Grammar reusable components at regular width', (tester) async {
    await tester.binding.setSurfaceSize(const Size(788, 720));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final controller = TextEditingController(text: 'She works here.');
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light().copyWith(platform: TargetPlatform.android),
        home: Scaffold(
          body: RepaintBoundary(
            key: const ValueKey('grammar-components'),
            child: Padding(
              padding: const EdgeInsets.all(SpaceTokens.xl),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: LayoutTokens.lessonCardMinHeight,
                      child: LessonCard(
                        variant: LessonCardVariant.grammar,
                        indexLabel: '01',
                        level: 'A1',
                        title: 'Verb agreement',
                        description: 'Correct agreement mistakes.',
                        actionLabel: 'Start',
                        onPressed: _noop,
                      ),
                    ),
                  ),
                  const SizedBox(width: SpaceTokens.xl),
                  Expanded(
                    child: Column(
                      children: [
                        const SourceTextCard(
                          variant: SourceTextCardVariant.sentence,
                          text: 'She work here.',
                          semanticLabel: 'Sentence',
                          instruction: 'Correct the sentence.',
                        ),
                        const SizedBox(height: SpaceTokens.lg),
                        AnswerInput(
                          paletteKey: AnswerPaletteKey.blue,
                          controller: controller,
                          label: 'Your correction',
                          placeholder: 'Type the corrected sentence…',
                          enabled: true,
                          autofocus: false,
                          onChanged: (_) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await expectLater(
      find.byKey(const ValueKey('grammar-components')),
      matchesGoldenFile('goldens/grammar_components_regular.png'),
    );
  });

  testWidgets('Grammar feedback variants at regular width', (tester) async {
    await tester.binding.setSurfaceSize(const Size(788, 720));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light().copyWith(platform: TargetPlatform.android),
        home: Scaffold(
          body: RepaintBoundary(
            key: const ValueKey('grammar-feedback'),
            child: Padding(
              padding: const EdgeInsets.all(SpaceTokens.xl),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FeedbackSheet.grammarCorrect(
                      title: 'Correct',
                      answer: 'She works here.',
                      recapLabel: 'Your answer',
                      analysisLabel: 'View AI analysis',
                      analysisUnavailableReason: 'Unavailable locally.',
                      nextLabel: 'Next',
                      closeLabel: 'Close',
                      onAnalysis: null,
                      onNext: _noop,
                      onClose: _noop,
                    ),
                  ),
                  const SizedBox(width: SpaceTokens.lg),
                  Expanded(
                    child: FeedbackSheet.grammarIncorrect(
                      title: 'Not correct yet',
                      originalAnswer: 'She work here.',
                      correctedAnswer: 'She works here.',
                      explanation: 'Use third-person singular.',
                      bullets: const ['Add -s to the verb.'],
                      sectionLabel: 'Tips',
                      correctionLabel: 'Correction',
                      correctionSegments: const [
                        CorrectionSegment(
                          text: 'She',
                          kind: CorrectionSegmentKind.retained,
                        ),
                        CorrectionSegment(
                          text: 'work',
                          kind: CorrectionSegmentKind.removed,
                        ),
                        CorrectionSegment(
                          text: 'works',
                          kind: CorrectionSegmentKind.inserted,
                        ),
                        CorrectionSegment(
                          text: 'here',
                          kind: CorrectionSegmentKind.retained,
                        ),
                        CorrectionSegment(
                          text: '.',
                          kind: CorrectionSegmentKind.retained,
                        ),
                      ],
                      retainedLabel: 'kept',
                      removedLabel: 'remove',
                      insertedLabel: 'add',
                      fixLabel: 'Fix',
                      nextLabel: 'Next',
                      closeLabel: 'Close',
                      onFix: _noop,
                      onNext: _noop,
                      onClose: _noop,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await expectLater(
      find.byKey(const ValueKey('grammar-feedback')),
      matchesGoldenFile('goldens/grammar_feedback_regular.png'),
    );
  });

  testWidgets('Grammar exercise at compact width', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light().copyWith(platform: TargetPlatform.android),
        home: RepaintBoundary(
          key: const ValueKey('grammar-exercise'),
          child: ExerciseTemplate(
            leadingLabel: 'Close',
            onClose: _noop,
            progress: const ProgressStepper(
              variant: ProgressStepperVariant.grammar,
              step: 1,
              count: 20,
              semanticLabel: 'Grammar progress',
            ),
            source: const SourceTextCard(
              variant: SourceTextCardVariant.sentence,
              text: 'She work at the library every day.',
              semanticLabel: 'Sentence to correct',
              instruction: 'Rewrite the sentence so it is correct.',
              centerContent: true,
            ),
            answer: AnswerInput(
              paletteKey: AnswerPaletteKey.blue,
              controller: controller,
              label: 'Your correction',
              placeholder: 'Type the corrected sentence…',
              enabled: true,
              autofocus: false,
              centerContent: true,
              onChanged: (_) {},
            ),
            hints: HintChipBar(
              hints: const ['Look at the subject.'],
              hintLabel: (index) => 'Hint ${index + 1}',
            ),
            submit: const SubmitButton(
              label: 'Submit',
              onPressed: null,
              loading: false,
            ),
            balancedWorkspace: true,
          ),
        ),
      ),
    );
    await expectLater(
      find.byKey(const ValueKey('grammar-exercise')),
      matchesGoldenFile('goldens/grammar_exercise_compact.png'),
    );
  });
}

void _noop() {}
