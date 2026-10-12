import 'package:flutter/material.dart';

import '../primitives/canonical_focus_indicator.dart';
import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';

class DeckCard extends StatelessWidget {
  const DeckCard({
    required this.title,
    required this.subtitle,
    required this.countLabel,
    required this.onPressed,
    super.key,
  });

  final String title;
  final String subtitle;
  final String countLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: '$title, $subtitle, $countLabel',
    child: CanonicalFocusIndicator(
      borderRadius: BorderRadius.circular(RadiusTokens.card),
      child: Material(
        color: ColorTokens.surface,
        borderRadius: BorderRadius.circular(RadiusTokens.card),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(RadiusTokens.card),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: LayoutTokens.deckCardHeight,
            ),
            padding: const EdgeInsets.all(SpaceTokens.lg),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RadiusTokens.card),
              boxShadow: ShadowTokens.hairline,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: TypographyTokens.heading),
                      const SizedBox(height: SpaceTokens.xs),
                      Text(
                        subtitle,
                        style: TypographyTokens.caption.copyWith(
                          color: ColorTokens.textSecondary,
                        ),
                      ),
                      const SizedBox(height: SpaceTokens.xs),
                      Text(
                        countLabel,
                        style: TypographyTokens.microLabel.copyWith(
                          color: ColorTokens.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: SpaceTokens.md),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: IconTokens.control,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class FlashcardDeckHeader extends StatelessWidget {
  const FlashcardDeckHeader({
    required this.title,
    required this.description,
    required this.newCount,
    required this.learningCount,
    required this.dueCount,
    required this.newLabel,
    required this.learningLabel,
    required this.dueLabel,
    required this.reviewLabel,
    this.onReview,
    super.key,
  });

  final String title;
  final String description;
  final int newCount;
  final int learningCount;
  final int dueCount;
  final String newLabel;
  final String learningLabel;
  final String dueLabel;
  final String reviewLabel;
  final VoidCallback? onReview;

  @override
  Widget build(BuildContext context) {
    final accessible = Theme.of(context)
        .extension<DesignTokensTheme>()!
        .accessible;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(SpaceTokens.xl),
      decoration: BoxDecoration(
        color: accessible.brandFill,
        borderRadius: BorderRadius.circular(RadiusTokens.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TypographyTokens.title.copyWith(color: accessible.onBrand),
          ),
          const SizedBox(height: SpaceTokens.xs),
          Text(
            description,
            style: TypographyTokens.body.copyWith(color: accessible.onBrand),
          ),
          const SizedBox(height: SpaceTokens.xl),
          Row(
            children: [
              _DeckCounter(value: newCount, label: newLabel),
              const SizedBox(width: SpaceTokens.xl),
              _DeckCounter(value: learningCount, label: learningLabel),
              const SizedBox(width: SpaceTokens.xl),
              _DeckCounter(value: dueCount, label: dueLabel),
            ],
          ),
          const SizedBox(height: SpaceTokens.xl),
          CanonicalFocusIndicator(
            borderRadius: BorderRadius.circular(RadiusTokens.full),
            child: FilledButton(
              onPressed: onReview,
              style: FilledButton.styleFrom(
                minimumSize: const Size(0, ControlTokens.minTouchTarget),
                backgroundColor: ColorTokens.surface,
                foregroundColor: accessible.link,
                padding: const EdgeInsets.symmetric(horizontal: SpaceTokens.lg),
                textStyle: TypographyTokens.bodyStrong,
                shape: const StadiumBorder(),
              ),
              child: Text(reviewLabel),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeckCounter extends StatelessWidget {
  const _DeckCounter({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final foreground = Theme.of(context)
        .extension<DesignTokensTheme>()!
        .accessible
        .onBrand;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$value',
            style: TypographyTokens.title.copyWith(color: foreground),
          ),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TypographyTokens.caption.copyWith(color: foreground),
          ),
        ],
      ),
    );
  }
}

class FlashcardRow extends StatelessWidget {
  const FlashcardRow({
    required this.word,
    required this.pronunciation,
    required this.translation,
    required this.partOfSpeech,
    super.key,
  });

  final String word;
  final String pronunciation;
  final String translation;
  final String partOfSpeech;

  @override
  Widget build(BuildContext context) {
    final accessible = Theme.of(context)
        .extension<DesignTokensTheme>()!
        .accessible;
    return Semantics(
      label: '$word, $pronunciation, $partOfSpeech, $translation',
      child: Container(
        constraints: const BoxConstraints(minHeight: LayoutTokens.rowWord),
        padding: const EdgeInsets.all(SpaceTokens.lg),
        decoration: BoxDecoration(
          color: ColorTokens.surface,
          borderRadius: BorderRadius.circular(RadiusTokens.xs),
          boxShadow: ShadowTokens.hairline,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(word, style: TypographyTokens.heading),
                  const SizedBox(height: SpaceTokens.xs),
                  Text(
                    pronunciation,
                    style: TypographyTokens.caption.copyWith(
                      color: ColorTokens.textSecondary,
                    ),
                  ),
                  const SizedBox(height: SpaceTokens.xs),
                  Text(translation, style: TypographyTokens.body),
                ],
              ),
            ),
            const SizedBox(width: SpaceTokens.md),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: SpaceTokens.sm,
                vertical: SpaceTokens.xs,
              ),
              decoration: BoxDecoration(
                color: FeatureTokens.srsPosBadgeBg,
                borderRadius: BorderRadius.circular(RadiusTokens.chip),
              ),
              child: Text(
                partOfSpeech,
                style: TypographyTokens.microLabel.copyWith(
                  color: accessible.textOnPrimaryTint,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppSegmentedControl extends StatelessWidget {
  const AppSegmentedControl({
    required this.firstLabel,
    required this.secondLabel,
    this.onSecondPressed,
    super.key,
  });

  final String firstLabel;
  final String secondLabel;
  final VoidCallback? onSecondPressed;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(SpaceTokens.xs),
    decoration: BoxDecoration(
      color: ColorTokens.surfaceMuted,
      borderRadius: BorderRadius.circular(RadiusTokens.full),
    ),
    child: Row(
      children: [
        Expanded(
          child: Semantics(
            selected: true,
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(
                minHeight: ControlTokens.minTouchTarget,
              ),
              decoration: BoxDecoration(
                color: ColorTokens.surface,
                borderRadius: BorderRadius.circular(RadiusTokens.full),
              ),
              child: Text(firstLabel, style: TypographyTokens.bodyStrong),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: onSecondPressed,
            child: Text(
              secondLabel,
              style: TypographyTokens.body.copyWith(
                color: ColorTokens.textSecondary,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
