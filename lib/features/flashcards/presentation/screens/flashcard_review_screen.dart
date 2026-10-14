import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../../domain/flashcard_deck.dart';
import '../flashcard_copy.dart';
import '../flashcard_providers.dart';

/// A local practice session. Grades advance the queue but do not calculate SRS dates.
class FlashcardReviewScreen extends ConsumerStatefulWidget {
  const FlashcardReviewScreen({
    required this.deckId,
    required this.copy,
    required this.onClose,
    super.key,
  });

  final String deckId;
  final FlashcardCopy copy;
  final VoidCallback onClose;

  @override
  ConsumerState<FlashcardReviewScreen> createState() =>
      _FlashcardReviewScreenState();
}

class _FlashcardReviewScreenState extends ConsumerState<FlashcardReviewScreen> {
  var _index = 0;
  var _flipped = false;

  void _next() => setState(() {
    _index++;
    _flipped = false;
  });

  @override
  Widget build(BuildContext context) {
    final deck = ref.watch(flashcardDeckProvider(widget.deckId));
    final words = deck?.words ?? const <FlashcardWord>[];
    final complete = _index >= words.length;
    return AppScaffold(
      backgroundColor: ColorTokens.backgroundPlain,
      child: Column(
        children: [
          ContentConstraints(
            child: AppHeader(
              variant: AppHeaderVariant.progress,
              title: '',
              leadingLabel: widget.copy.close,
              onLeadingPressed: widget.onClose,
            ),
          ),
          if (words.isNotEmpty)
            ContentConstraints(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: SpaceTokens.lg),
                child: LinearProgressIndicator(
                  value: _index / words.length,
                  color: FeatureTokens.srsAccent,
                  backgroundColor: ColorTokens.surfaceMuted,
                ),
              ),
            ),
          Expanded(
            child: ContentConstraints(
              child: Padding(
                padding: const EdgeInsets.all(SpaceTokens.lg),
                child: deck == null
                    ? Center(
                        child: EmptyState(
                          title: widget.copy.unavailableTitle,
                          body: widget.copy.unavailableBody,
                        ),
                      )
                    : complete
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.copy.completeTitle,
                              style: TypographyTokens.title,
                            ),
                            const SizedBox(height: SpaceTokens.sm),
                            Text(
                              widget.copy.completeBody,
                              style: TypographyTokens.body,
                            ),
                            const SizedBox(height: SpaceTokens.xl),
                            AppButton(
                              label: widget.copy.done,
                              onPressed: widget.onClose,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: SRSCard(
                                key: ValueKey(_index),
                                word: words[_index].term,
                                pronunciation: words[_index].pronunciation,
                                partOfSpeech: words[_index].partOfSpeech,
                                translation: words[_index].translation,
                                flipHint: widget.copy.flipHint,
                                flipped: _flipped,
                                onFlip: () =>
                                    setState(() => _flipped = !_flipped),
                              ),
                            ),
                          ),
                          Text(
                            widget.copy.practiceNotice,
                            textAlign: TextAlign.center,
                            style: TypographyTokens.caption.copyWith(
                              color: ColorTokens.textSecondary,
                            ),
                          ),
                          const SizedBox(height: SpaceTokens.md),
                          Row(
                            children: [
                              for (final (grade, label) in [
                                (SRSGrade.again, widget.copy.again),
                                (SRSGrade.hard, widget.copy.hard),
                                (SRSGrade.good, widget.copy.good),
                                (SRSGrade.easy, widget.copy.easy),
                              ])
                                Expanded(
                                  child: SRSGradeButton(
                                    grade: grade,
                                    label: label,
                                    onPressed: _next,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
