import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../components/browse_components.dart';
import '../components/feedback_sheet.dart';
import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';

@Preview(name: 'Writing cards and feedback', size: Size(788, 720))
Widget verticalSlicePreview() => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.light(),
  home: Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(SpaceTokens.xl),
      // Preview-only fixture copy, never product chrome.
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
              variant: FeedbackSheetVariant.writingCorrect,
              title: 'Excellent',
              correctedAnswer: 'I practice English every morning.',
              originalAnswer: 'I practice English every morning.',
              explanation: 'Use the simple present for a repeated daily habit.',
              bullets: const ['Natural word order', 'Clear, complete sentence'],
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
);

void _noop() {}
