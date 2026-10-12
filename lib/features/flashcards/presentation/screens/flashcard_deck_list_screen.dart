import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../flashcard_copy.dart';
import '../flashcard_providers.dart';

class FlashcardDeckListScreen extends ConsumerWidget {
  const FlashcardDeckListScreen({
    required this.copy,
    required this.onBack,
    required this.onDeckPressed,
    super.key,
  });

  final FlashcardCopy copy;
  final VoidCallback onBack;
  final ValueChanged<String> onDeckPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decks = ref.watch(flashcardDecksProvider);
    return AppScaffold(
      backgroundColor: ColorTokens.backgroundPlain,
      child: Column(
        children: [
          ContentConstraints(
            child: AppHeader(
              variant: AppHeaderVariant.pushed,
              title: copy.title,
              leadingLabel: copy.back,
              onLeadingPressed: onBack,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ContentConstraints(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: SpaceTokens.xxl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        header: true,
                        child: Text(
                          copy.title,
                          style: TypographyTokens.display,
                        ),
                      ),
                      const SizedBox(height: SpaceTokens.xs),
                      Text(
                        copy.deckCount(decks.length),
                        style: TypographyTokens.body.copyWith(
                          color: ColorTokens.textSecondary,
                        ),
                      ),
                      const SizedBox(height: SpaceTokens.xl),
                      if (decks.isEmpty)
                        EmptyState(title: copy.emptyTitle, body: copy.emptyBody)
                      else
                        for (final deck in decks) ...[
                          DeckCard(
                            title: deck.title,
                            subtitle: deck.description,
                            countLabel: copy.deckSummary(
                              deck.newCount,
                              deck.learningCount,
                              deck.dueCount,
                            ),
                            onPressed: () => onDeckPressed(deck.id),
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
