import 'dart:ui' show SemanticsRole;

import 'package:flutter/material.dart';

import '../primitives/canonical_focus_indicator.dart';
import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';
import 'app_button.dart';

enum FeedbackSheetVariant {
  writingCorrect,
  writingIncorrect,
  grammarCorrect,
  grammarIncorrect,
}

sealed class FeedbackSheetActions {
  const FeedbackSheetActions();
}

final class EditNextFeedbackActions extends FeedbackSheetActions {
  const EditNextFeedbackActions({
    required this.editLabel,
    required this.nextLabel,
    required this.onEdit,
    required this.onNext,
  });

  final String editLabel;
  final String nextLabel;
  final VoidCallback onEdit;
  final VoidCallback onNext;
}

final class FixNextFeedbackActions extends FeedbackSheetActions {
  const FixNextFeedbackActions({
    required this.fixLabel,
    required this.nextLabel,
    required this.onFix,
    required this.onNext,
  });

  final String fixLabel;
  final String nextLabel;
  final VoidCallback onFix;
  final VoidCallback onNext;
}

final class NextFullFeedbackActions extends FeedbackSheetActions {
  const NextFullFeedbackActions({
    required this.nextLabel,
    required this.onNext,
  });

  final String nextLabel;
  final VoidCallback onNext;
}

class FeedbackSheet extends StatelessWidget {
  FeedbackSheet.writingCorrect({
    required this.title,
    required this.originalAnswer,
    required this.correctedAnswer,
    required this.explanation,
    required this.bullets,
    required this.sectionLabel,
    required this.correctionLabel,
    required String editLabel,
    required String nextLabel,
    required this.closeLabel,
    required VoidCallback onEdit,
    required VoidCallback onNext,
    required this.onClose,
    this.onMinimize,
    this.minimizeLabel,
    this.minimizeFocusNode,
    this.closeFocusNode,
    this.titleFocusNode,
    super.key,
  }) : assert(onMinimize == null || minimizeLabel != null),
       variant = FeedbackSheetVariant.writingCorrect,
       recapLabel = null,
       analysisLabel = null,
       analysisUnavailableReason = null,
       onAnalysis = null,
       actions = EditNextFeedbackActions(
         editLabel: editLabel,
         nextLabel: nextLabel,
         onEdit: onEdit,
         onNext: onNext,
       );

  FeedbackSheet.writingIncorrect({
    required this.title,
    required this.originalAnswer,
    required this.correctedAnswer,
    required this.explanation,
    required this.bullets,
    required this.sectionLabel,
    required this.correctionLabel,
    required String editLabel,
    required String nextLabel,
    required this.closeLabel,
    required VoidCallback onEdit,
    required VoidCallback onNext,
    required this.onClose,
    this.onMinimize,
    this.minimizeLabel,
    this.minimizeFocusNode,
    this.closeFocusNode,
    this.titleFocusNode,
    super.key,
  }) : assert(onMinimize == null || minimizeLabel != null),
       variant = FeedbackSheetVariant.writingIncorrect,
       recapLabel = null,
       analysisLabel = null,
       analysisUnavailableReason = null,
       onAnalysis = null,
       actions = EditNextFeedbackActions(
         editLabel: editLabel,
         nextLabel: nextLabel,
         onEdit: onEdit,
         onNext: onNext,
       );

  FeedbackSheet.grammarCorrect({
    required this.title,
    required String answer,
    required this.recapLabel,
    required this.analysisLabel,
    this.analysisUnavailableReason,
    required String nextLabel,
    required this.closeLabel,
    required this.onAnalysis,
    required VoidCallback onNext,
    required this.onClose,
    this.onMinimize,
    this.minimizeLabel,
    this.minimizeFocusNode,
    this.closeFocusNode,
    this.titleFocusNode,
    super.key,
  }) : assert(onMinimize == null || minimizeLabel != null),
       variant = FeedbackSheetVariant.grammarCorrect,
       originalAnswer = answer,
       correctedAnswer = null,
       explanation = null,
       bullets = const [],
       sectionLabel = null,
       correctionLabel = null,
       actions = NextFullFeedbackActions(nextLabel: nextLabel, onNext: onNext);

  FeedbackSheet.grammarIncorrect({
    required this.title,
    required this.originalAnswer,
    required this.correctedAnswer,
    required this.explanation,
    required this.bullets,
    required this.sectionLabel,
    required this.correctionLabel,
    required String fixLabel,
    required String nextLabel,
    required this.closeLabel,
    required VoidCallback onFix,
    required VoidCallback onNext,
    required this.onClose,
    this.onMinimize,
    this.minimizeLabel,
    this.minimizeFocusNode,
    this.closeFocusNode,
    this.titleFocusNode,
    super.key,
  }) : assert(onMinimize == null || minimizeLabel != null),
       variant = FeedbackSheetVariant.grammarIncorrect,
       recapLabel = null,
       analysisLabel = null,
       analysisUnavailableReason = null,
       onAnalysis = null,
       actions = FixNextFeedbackActions(
         fixLabel: fixLabel,
         nextLabel: nextLabel,
         onFix: onFix,
         onNext: onNext,
       );

  static Widget loading({
    required String gradingLabel,
    required String cancelLabel,
    required VoidCallback onCancel,
    FocusNode? titleFocusNode,
  }) => _FeedbackSheetLoading(
    gradingLabel: gradingLabel,
    cancelLabel: cancelLabel,
    onCancel: onCancel,
    titleFocusNode: titleFocusNode,
  );

  final FeedbackSheetVariant variant;
  final String title;
  final String? originalAnswer;
  final String? correctedAnswer;
  final String? explanation;
  final List<String> bullets;
  final String? sectionLabel;
  final String? correctionLabel;
  final String? recapLabel;
  final String? analysisLabel;
  final String? analysisUnavailableReason;
  final String closeLabel;
  final VoidCallback? onAnalysis;
  final VoidCallback onClose;
  final VoidCallback? onMinimize;
  final String? minimizeLabel;
  final FocusNode? minimizeFocusNode;
  final FocusNode? closeFocusNode;
  final FocusNode? titleFocusNode;
  final FeedbackSheetActions actions;

  bool get _correct => switch (variant) {
    FeedbackSheetVariant.writingCorrect ||
    FeedbackSheetVariant.grammarCorrect => true,
    FeedbackSheetVariant.writingIncorrect ||
    FeedbackSheetVariant.grammarIncorrect => false,
  };

  @override
  Widget build(BuildContext context) {
    final accessible = Theme.of(context)
        .extension<DesignTokensTheme>()!
        .accessible;
    return Semantics(
      key: const Key('feedback-live-region'),
      role: SemanticsRole.dialog,
      liveRegion: true,
      label: title,
      container: true,
      explicitChildNodes: true,
      child: Container(
        key: Key(_correct ? 'feedback-correct' : 'feedback-incorrect'),
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
            const _SheetGrabber(),
            Row(
              children: [
                Icon(
                  _correct ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: _correct
                      ? FeedbackTokens.correct
                      : FeedbackTokens.incorrect,
                ),
                const SizedBox(width: SpaceTokens.sm),
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Focus(
                      key: const Key('feedback-title-focus'),
                      focusNode: titleFocusNode,
                      canRequestFocus: titleFocusNode != null,
                      child: ExcludeSemantics(
                        child: Text(
                          title,
                          style: TypographyTokens.heading.copyWith(
                            color: _correct
                                ? accessible.successText
                                : accessible.errorText,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (onMinimize != null)
                  Semantics(
                    button: true,
                    label: minimizeLabel,
                    onTap: onMinimize,
                    child: ExcludeSemantics(
                      child: CanonicalFocusIndicator(
                        borderRadius: BorderRadius.circular(RadiusTokens.full),
                        child: IconButton(
                          key: const Key('feedback-minimize'),
                          focusNode: minimizeFocusNode,
                          tooltip: minimizeLabel,
                          onPressed: onMinimize,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        ),
                      ),
                    ),
                  ),
                Semantics(
                  button: true,
                  label: closeLabel,
                  onTap: onClose,
                  child: ExcludeSemantics(
                    child: CanonicalFocusIndicator(
                      borderRadius: BorderRadius.circular(RadiusTokens.full),
                      child: IconButton(
                        key: const Key('feedback-close'),
                        focusNode: closeFocusNode,
                        tooltip: closeLabel,
                        onPressed: onClose,
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: SpaceTokens.md),
            switch (variant) {
              FeedbackSheetVariant.grammarCorrect => _AnswerRecapBox(
                label: recapLabel!,
                answer: originalAnswer!,
                analysisLabel: analysisLabel!,
                onAnalysis: onAnalysis,
                unavailableReason: analysisUnavailableReason,
              ),
              FeedbackSheetVariant.writingCorrect ||
              FeedbackSheetVariant.writingIncorrect ||
              FeedbackSheetVariant.grammarIncorrect => _CorrectionBody(
                correct: _correct,
                originalAnswer: originalAnswer!,
                correctedAnswer: correctedAnswer!,
                explanation: explanation!,
                correctionLabel: correctionLabel!,
                sectionLabel: sectionLabel!,
                bullets: bullets,
                bulletColor: variant == FeedbackSheetVariant.grammarIncorrect
                    ? FeedbackTokens.bulletTip
                    : FeedbackTokens.bulletImprovement,
              ),
            },
            const SizedBox(height: SpaceTokens.md),
            FeedbackActionRow(actions: actions),
          ],
        ),
      ),
    );
  }
}

class FeedbackActionRow extends StatelessWidget {
  const FeedbackActionRow({required this.actions, super.key});

  final FeedbackSheetActions actions;

  @override
  Widget build(BuildContext context) {
    final paired = switch (actions) {
      EditNextFeedbackActions(
        :final editLabel,
        :final nextLabel,
        :final onEdit,
        :final onNext,
      ) =>
        (
          secondaryLabel: editLabel,
          primaryLabel: nextLabel,
          onSecondary: onEdit,
          onPrimary: onNext,
        ),
      FixNextFeedbackActions(
        :final fixLabel,
        :final nextLabel,
        :final onFix,
        :final onNext,
      ) =>
        (
          secondaryLabel: fixLabel,
          primaryLabel: nextLabel,
          onSecondary: onFix,
          onPrimary: onNext,
        ),
      NextFullFeedbackActions() => null,
    };
    if (actions case NextFullFeedbackActions(:final nextLabel, :final onNext)) {
      return AppButton(label: nextLabel, onPressed: onNext, fullWidth: true);
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final stack = constraints.maxWidth < LayoutTokens.stackActionsBelow;
        if (stack) {
          return Column(
            children: [
              AppButton(
                label: paired!.primaryLabel,
                onPressed: paired.onPrimary,
                fullWidth: true,
              ),
              const SizedBox(height: SpaceTokens.sm),
              AppButton(
                label: paired.secondaryLabel,
                onPressed: paired.onSecondary,
                variant: AppButtonVariant.secondary,
                fullWidth: true,
              ),
            ],
          );
        }
        return Row(
          children: [
            Expanded(
              child: AppButton(
                label: paired!.secondaryLabel,
                onPressed: paired.onSecondary,
                variant: AppButtonVariant.secondary,
                fullWidth: true,
              ),
            ),
            const SizedBox(width: SpaceTokens.sm),
            Expanded(
              child: AppButton(
                label: paired.primaryLabel,
                onPressed: paired.onPrimary,
                fullWidth: true,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CorrectionBody extends StatelessWidget {
  const _CorrectionBody({
    required this.correct,
    required this.originalAnswer,
    required this.correctedAnswer,
    required this.explanation,
    required this.correctionLabel,
    required this.sectionLabel,
    required this.bullets,
    required this.bulletColor,
  });

  final bool correct;
  final String originalAnswer;
  final String correctedAnswer;
  final String explanation;
  final String correctionLabel;
  final String sectionLabel;
  final List<String> bullets;
  final Color bulletColor;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
        sectionLabel.toUpperCase(),
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
              Icon(Icons.circle, color: bulletColor, size: SpaceTokens.sm),
              const SizedBox(width: SpaceTokens.sm),
              Expanded(child: Text(bullet, style: TypographyTokens.body)),
            ],
          ),
        ),
      ),
    ],
  );
}

class _AnswerRecapBox extends StatelessWidget {
  const _AnswerRecapBox({
    required this.label,
    required this.answer,
    required this.analysisLabel,
    required this.onAnalysis,
    this.unavailableReason,
  });

  final String label;
  final String answer;
  final String analysisLabel;
  final VoidCallback? onAnalysis;
  final String? unavailableReason;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: FeedbackTokens.correct,
            size: IconTokens.inline,
          ),
          const SizedBox(width: SpaceTokens.xs),
          Text(
            label.toUpperCase(),
            style: TypographyTokens.microLabel.copyWith(
              color: ColorTokens.textSecondary,
            ),
          ),
        ],
      ),
      const SizedBox(height: SpaceTokens.sm),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(SpaceTokens.md),
        decoration: BoxDecoration(
          color: ColorTokens.surfaceMuted,
          borderRadius: BorderRadius.circular(RadiusTokens.control),
        ),
        child: Text(answer, style: TypographyTokens.body),
      ),
      Semantics(
        enabled: onAnalysis != null,
        label: unavailableReason == null
            ? analysisLabel
            : '$analysisLabel. $unavailableReason',
        child: ExcludeSemantics(
          child: AppButton(
            label: analysisLabel,
            onPressed: onAnalysis,
            variant: AppButtonVariant.link,
          ),
        ),
      ),
      if (unavailableReason case final reason?)
        Text(
          reason,
          style: TypographyTokens.caption.copyWith(
            color: ColorTokens.textSecondary,
          ),
        ),
    ],
  );
}

class _SheetGrabber extends StatelessWidget {
  const _SheetGrabber();

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      width: SpaceTokens.xxl,
      height: SpaceTokens.xs,
      decoration: BoxDecoration(
        color: ColorTokens.border,
        borderRadius: BorderRadius.circular(RadiusTokens.full),
      ),
    ),
  );
}

class _FeedbackSheetLoading extends StatelessWidget {
  const _FeedbackSheetLoading({
    required this.gradingLabel,
    required this.cancelLabel,
    required this.onCancel,
    this.titleFocusNode,
  });

  final String gradingLabel;
  final String cancelLabel;
  final VoidCallback onCancel;
  final FocusNode? titleFocusNode;

  @override
  Widget build(BuildContext context) => Semantics(
    key: const Key('feedback-loading-live-region'),
    role: SemanticsRole.dialog,
    liveRegion: true,
    label: gradingLabel,
    container: true,
    explicitChildNodes: true,
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
              Semantics(
                header: true,
                child: Focus(
                  key: const Key('feedback-loading-title-focus'),
                  focusNode: titleFocusNode,
                  canRequestFocus: titleFocusNode != null,
                  child: ExcludeSemantics(
                    child: Text(gradingLabel, style: TypographyTokens.heading),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: SpaceTokens.lg),
          const _SkeletonBar(),
          const SizedBox(height: SpaceTokens.sm),
          const _SkeletonBar(),
          Align(
            alignment: Alignment.centerRight,
            child: AppButton(
              label: cancelLabel,
              onPressed: onCancel,
              variant: AppButtonVariant.secondary,
            ),
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

class InlineError extends StatelessWidget {
  const InlineError({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
    this.cancelLabel,
    this.onCancel,
    this.retryFocusNode,
    super.key,
  }) : assert((cancelLabel == null) == (onCancel == null));

  final String message;
  final String retryLabel;
  final VoidCallback onRetry;
  final String? cancelLabel;
  final VoidCallback? onCancel;
  final FocusNode? retryFocusNode;

  @override
  Widget build(BuildContext context) {
    final accessible =
        Theme.of(context).extension<DesignTokensTheme>()?.accessible ??
        const AccessibleTokens();
    return Semantics(
      key: const Key('inline-error-alert'),
      role: SemanticsRole.alert,
      label: message,
      container: true,
      explicitChildNodes: true,
      child: Container(
        key: const Key('inline-error'),
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(SpaceTokens.md),
              decoration: BoxDecoration(
                color: ColorTokens.surfaceMuted,
                borderRadius: BorderRadius.circular(RadiusTokens.control),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: ColorTokens.error,
                  ),
                  const SizedBox(width: SpaceTokens.sm),
                  Expanded(
                    child: ExcludeSemantics(
                      child: Text(
                        message,
                        style: TypographyTokens.body.copyWith(
                          color: accessible.errorText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: SpaceTokens.sm),
                  AppButton(
                    key: const Key('inline-error-retry'),
                    label: retryLabel,
                    onPressed: onRetry,
                    focusNode: retryFocusNode,
                    autofocus: true,
                    variant: AppButtonVariant.link,
                  ),
                ],
              ),
            ),
            if (cancelLabel case final label?) ...[
              const SizedBox(height: SpaceTokens.sm),
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  label: label,
                  onPressed: onCancel,
                  variant: AppButtonVariant.secondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
