import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';
import 'app_button.dart';

enum FeedbackSheetVariant { writingCorrect, writingIncorrect }

class FeedbackSheet extends StatelessWidget {
  const FeedbackSheet({
    required this.variant,
    required this.title,
    required this.correctedAnswer,
    required this.originalAnswer,
    required this.explanation,
    required this.bullets,
    required this.correctionLabel,
    required this.improvementsLabel,
    required this.editLabel,
    required this.nextLabel,
    required this.closeLabel,
    required this.onEdit,
    required this.onNext,
    required this.onClose,
    super.key,
  });

  static Widget loading({
    required String gradingLabel,
    required String cancelLabel,
    required VoidCallback onCancel,
  }) => _FeedbackSheetLoading(
    gradingLabel: gradingLabel,
    cancelLabel: cancelLabel,
    onCancel: onCancel,
  );

  final FeedbackSheetVariant variant;
  final String title;
  final String correctedAnswer;
  final String originalAnswer;
  final String explanation;
  final List<String> bullets;
  final String correctionLabel;
  final String improvementsLabel;
  final String editLabel;
  final String nextLabel;
  final String closeLabel;
  final VoidCallback onEdit;
  final VoidCallback onNext;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final correct = variant == FeedbackSheetVariant.writingCorrect;
    final accessible = Theme.of(context)
        .extension<DesignTokensTheme>()!
        .accessible;
    return Semantics(
      liveRegion: true,
      label: title,
      child: Container(
        key: Key(correct ? 'feedback-correct' : 'feedback-incorrect'),
        padding: const EdgeInsets.all(SpaceTokens.lg),
        decoration: BoxDecoration(
          color: ColorTokens.surfaceElevated,
          borderRadius: BorderRadius.circular(RadiusTokens.sheet),
          boxShadow: ShadowTokens.floating,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: SpaceTokens.xxl,
                height: SpaceTokens.xs,
                decoration: BoxDecoration(
                  color: ColorTokens.border,
                  borderRadius: BorderRadius.circular(RadiusTokens.full),
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  correct ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: correct
                      ? FeedbackTokens.correct
                      : FeedbackTokens.incorrect,
                ),
                const SizedBox(width: SpaceTokens.sm),
                Expanded(
                  child: Text(
                    title,
                    style: TypographyTokens.heading.copyWith(
                      color: correct
                          ? accessible.successText
                          : accessible.errorText,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: closeLabel,
                  onPressed: onClose,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: SpaceTokens.md),
            Text(
              correctionLabel.toUpperCase(),
              style: TypographyTokens.microLabel.copyWith(
                color: ColorTokens.textSecondary,
              ),
            ),
            const SizedBox(height: SpaceTokens.xs),
            Text.rich(
              TextSpan(
                style: TypographyTokens.body,
                children: [
                  TextSpan(
                    text: originalAnswer,
                    style: TextStyle(
                      color: correct
                          ? ColorTokens.textPrimary
                          : ColorTokens.errorText,
                      decoration: correct ? null : TextDecoration.lineThrough,
                    ),
                  ),
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: correctedAnswer,
                    style: TypographyTokens.bodyStrong.copyWith(
                      color: ColorTokens.successText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SpaceTokens.md),
            Text(explanation, style: TypographyTokens.body),
            const SizedBox(height: SpaceTokens.md),
            Text(
              improvementsLabel.toUpperCase(),
              style: TypographyTokens.microLabel.copyWith(
                color: ColorTokens.textSecondary,
              ),
            ),
            const SizedBox(height: SpaceTokens.xs),
            ...bullets.map(
              (bullet) => Padding(
                padding: const EdgeInsets.only(bottom: SpaceTokens.xs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.circle,
                      color: FeedbackTokens.bulletImprovement,
                      size: SpaceTokens.sm,
                    ),
                    const SizedBox(width: SpaceTokens.sm),
                    Expanded(child: Text(bullet, style: TypographyTokens.body)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: SpaceTokens.md),
            LayoutBuilder(
              builder: (context, constraints) {
                final stack =
                    constraints.maxWidth < LayoutTokens.stackActionsBelow;
                final buttons = [
                  Expanded(
                    child: AppButton(
                      label: editLabel,
                      onPressed: onEdit,
                      variant: AppButtonVariant.secondary,
                      fullWidth: true,
                    ),
                  ),
                  const SizedBox(width: SpaceTokens.sm, height: SpaceTokens.sm),
                  Expanded(
                    child: AppButton(
                      label: nextLabel,
                      onPressed: onNext,
                      fullWidth: true,
                    ),
                  ),
                ];
                if (!stack) return Row(children: buttons);
                return Column(
                  children: [
                    AppButton(
                      label: nextLabel,
                      onPressed: onNext,
                      fullWidth: true,
                    ),
                    const SizedBox(height: SpaceTokens.sm),
                    AppButton(
                      label: editLabel,
                      onPressed: onEdit,
                      variant: AppButtonVariant.secondary,
                      fullWidth: true,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedbackSheetLoading extends StatelessWidget {
  const _FeedbackSheetLoading({
    required this.gradingLabel,
    required this.cancelLabel,
    required this.onCancel,
  });

  final String gradingLabel;
  final String cancelLabel;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    label: gradingLabel,
    child: Container(
      padding: const EdgeInsets.all(SpaceTokens.lg),
      decoration: BoxDecoration(
        color: ColorTokens.surfaceElevated,
        borderRadius: BorderRadius.circular(RadiusTokens.sheet),
        boxShadow: ShadowTokens.floating,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox.square(
                dimension: IconTokens.inline,
                child: CircularProgressIndicator(
                  strokeWidth: FocusTokens.ringWidth,
                ),
              ),
              const SizedBox(width: SpaceTokens.sm),
              Text(gradingLabel, style: TypographyTokens.heading),
            ],
          ),
          const SizedBox(height: SpaceTokens.lg),
          const _SkeletonBar(),
          const SizedBox(height: SpaceTokens.sm),
          const _SkeletonBar(),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: onCancel, child: Text(cancelLabel)),
          ),
        ],
      ),
    ),
  );
}

class _SkeletonBar extends StatelessWidget {
  const _SkeletonBar();

  @override
  Widget build(BuildContext context) => Container(
    height: SpaceTokens.lg,
    decoration: BoxDecoration(
      color: ColorTokens.surfaceMuted,
      borderRadius: BorderRadius.circular(RadiusTokens.xs),
    ),
  );
}
