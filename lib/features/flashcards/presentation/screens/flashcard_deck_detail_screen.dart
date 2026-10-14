import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../flashcard_copy.dart';
import '../flashcard_providers.dart';

class FlashcardDeckDetailScreen extends ConsumerWidget {
  const FlashcardDeckDetailScreen({
    required this.deckId,
    required this.copy,
    required this.onBack,
    required this.onReview,
    super.key,
  });

  final String deckId;
  final FlashcardCopy copy;
  final VoidCallback onBack;
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deck = ref.watch(flashcardDeckProvider(deckId));
    return AppScaffold(
      backgroundColor: ColorTokens.backgroundPlain,
      child: Column(
        children: [
          ContentConstraints(
            child: AppHeader(
              variant: AppHeaderVariant.pushed,
              title: deck?.title ?? copy.title,
              leadingLabel: copy.back,
              onLeadingPressed: onBack,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ContentConstraints(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: SpaceTokens.xxl),
                  child: deck == null
                      ? EmptyState(
                          title: copy.unavailableTitle,
                          body: copy.unavailableBody,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FlashcardDeckHeader(
                              title: deck.title,
                              description: deck.description,
                              newCount: deck.newCount,
                              learningCount: deck.learningCount,
                              dueCount: deck.dueCount,
                              newLabel: copy.newLabel,
                              learningLabel: copy.learningLabel,
                              dueLabel: copy.dueLabel,
                              reviewLabel: copy.reviewLabel(
                                deck.newCount + deck.dueCount,
                              ),
                              onReview: deck.words.isEmpty ? null : onReview,
                            ),
                            const SizedBox(height: SpaceTokens.lg),
                            AppSegmentedControl(
                              firstLabel: copy.wordsLabel,
                              secondLabel: copy.gameLabel,
                            ),
                            const SizedBox(height: SpaceTokens.lg),
                            for (final word in deck.words) ...[
                              FlashcardRow(
                                word: word.term,
                                pronunciation: word.pronunciation,
                                translation: word.translation,
                                partOfSpeech: word.partOfSpeech,
                              ),
                              const SizedBox(height: SpaceTokens.sm),
                            ],
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
