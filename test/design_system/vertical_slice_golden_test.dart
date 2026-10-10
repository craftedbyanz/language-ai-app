import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/design_system/components/browse_components.dart';
import 'package:lingua/design_system/components/feedback_sheet.dart';
import 'package:lingua/design_system/theme/app_theme.dart';
import 'package:lingua/design_system/tokens/generated/design_tokens.dart';

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
                      title: 'Daily life',
                      countLabel: '2 sets',
                      onPressed: _noop,
                    ),
                  ),
                  const SizedBox(width: SpaceTokens.xl),
                  Expanded(
                    child: FeedbackSheet(
                      variant: FeedbackSheetVariant.writingIncorrect,
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
                      improvementsLabel: 'Key improvements',
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
}

void _noop() {}
