import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../adaptive/window_size_class.dart';
import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';
import '../primitives/canonical_focus_indicator.dart';
import 'app_button.dart';

enum SectionHeaderAccent { writing, grammar, conversation }

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.eyebrow,
    required this.firstLine,
    required this.secondLine,
    required this.sizeClass,
    this.accent = SectionHeaderAccent.writing,
    this.focusNode,
    this.autofocus = false,
    super.key,
  });
  final String eyebrow;
  final String firstLine;
  final String secondLine;
  final WindowSizeClass sizeClass;
  final SectionHeaderAccent accent;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final accessible =
        Theme.of(context).extension<DesignTokensTheme>()?.accessible ??
        const AccessibleTokens();
    final style = sizeClass == WindowSizeClass.compact
        ? TypographyTokens.displayCompact
        : TypographyTokens.display;
    return Semantics(
      header: true,
      child: Focus(
        key: const Key('section-heading-focus'),
        focusNode: focusNode,
        canRequestFocus: focusNode != null,
        autofocus: autofocus,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eyebrow.toUpperCase(),
              style: TypographyTokens.microLabel.copyWith(
                color: ColorTokens.textSecondary,
              ),
            ),
            const SizedBox(height: SpaceTokens.xs),
            Text(firstLine, style: style),
            Text.rich(
              TextSpan(
                style: style.copyWith(color: accessible.heroSecondLine),
                children: [
                  TextSpan(text: secondLine),
                  TextSpan(
                    text: '.',
                    style: TextStyle(
                      color: switch (accent) {
                        SectionHeaderAccent.writing =>
                          FeatureTokens.writingAccent,
                        SectionHeaderAccent.grammar =>
                          FeatureTokens.grammarAccent,
                        SectionHeaderAccent.conversation =>
                          FeatureTokens.conversationAccent,
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    super.key,
  });
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final accessible =
        Theme.of(context).extension<DesignTokensTheme>()?.accessible ??
        const AccessibleTokens();
    return Semantics(
      checked: selected,
      inMutuallyExclusiveGroup: true,
      child: CanonicalFocusIndicator(
        borderRadius: BorderRadius.circular(RadiusTokens.full),
        child: ChoiceChip(
          label: Text(label),
          selected: selected,
          onSelected: (_) => onSelected(),
          backgroundColor: ColorTokens.surface,
          selectedColor: ColorTokens.surface,
          side: selected
              ? BorderSide(
                  color: accessible.warningText,
                  width: FocusTokens.ringWidth,
                )
              : BorderSide.none,
          labelStyle: TypographyTokens.bodyStrong,
          shape: const StadiumBorder(),
        ),
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  const TopicCard({
    required this.icon,
    required this.title,
    required this.countLabel,
    required this.onPressed,
    super.key,
  });
  final IconData icon;
  final String title;
  final String countLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: '$title, $countLabel',
    child: CanonicalFocusIndicator(
      borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
      child: Material(
        color: ColorTokens.surface,
        borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: LayoutTokens.topicCardHeight,
            ),
            padding: const EdgeInsets.all(SpaceTokens.lg),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
              boxShadow: ShadowTokens.hairline,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: ColorTokens.surfaceMuted,
                  child: Icon(icon, color: ColorTokens.textPrimary),
                ),
                const Spacer(),
                Text(title, style: TypographyTokens.heading),
                const SizedBox(height: SpaceTokens.xs),
                Text(
                  countLabel,
                  style: TypographyTokens.caption.copyWith(
                    color: ColorTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

enum LessonCardVariant { writing, grammar, conversation }

class LessonCard extends StatelessWidget {
  const LessonCard({
    required this.variant,
    required this.indexLabel,
    required this.level,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onPressed,
    super.key,
  });
  final LessonCardVariant variant;
  final String indexLabel;
  final String level;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    container: true,
    label: '$indexLabel, $level, $title, $description',
    child: Container(
      constraints: const BoxConstraints(
        minHeight: LayoutTokens.lessonCardMinHeight,
      ),
      padding: const EdgeInsets.all(SpaceTokens.xl),
      decoration: BoxDecoration(
        color: ColorTokens.surface,
        borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
        boxShadow: ShadowTokens.hairline,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpaceTokens.md,
                  vertical: SpaceTokens.xs,
                ),
                decoration: BoxDecoration(
                  color: ColorTokens.surfaceMuted,
                  borderRadius: BorderRadius.circular(RadiusTokens.full),
                ),
                child: Text(level, style: TypographyTokens.caption),
              ),
              ExcludeSemantics(
                child: Text(
                  indexLabel,
                  style: TypographyTokens.title.copyWith(
                    color: ColorTokens.textFaint,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(title, style: TypographyTokens.title),
          const SizedBox(height: SpaceTokens.sm),
          Text(
            description,
            style: TypographyTokens.body.copyWith(
              color: ColorTokens.textSecondary,
            ),
          ),
          const SizedBox(height: SpaceTokens.xl),
          Align(
            alignment: Alignment.centerRight,
            child: AppButton(
              label: actionLabel,
              onPressed: onPressed,
              variant: AppButtonVariant.accent,
              accent: switch (variant) {
                LessonCardVariant.writing => AppButtonAccent.writing,
                LessonCardVariant.grammar => AppButtonAccent.grammar,
                LessonCardVariant.conversation => AppButtonAccent.conversation,
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.title,
    required this.body,
    this.actionLabel,
    this.onAction,
    this.error = false,
    super.key,
  });

  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool error;

  @override
  Widget build(BuildContext context) => Semantics(
    container: true,
    liveRegion: error,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(SpaceTokens.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              error ? Icons.error_outline_rounded : Icons.inbox_outlined,
              color: error ? ColorTokens.errorText : ColorTokens.textSecondary,
            ),
            const SizedBox(height: SpaceTokens.sm),
            Text(title, style: TypographyTokens.heading),
            const SizedBox(height: SpaceTokens.xs),
            Text(body, textAlign: TextAlign.center),
            if (actionLabel case final label?) ...[
              const SizedBox(height: SpaceTokens.md),
              AppButton(
                label: label,
                onPressed: onAction,
                variant: AppButtonVariant.secondary,
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

class PagerDots extends StatelessWidget {
  const PagerDots({
    required this.count,
    required this.index,
    required this.semanticLabel,
    required this.positionLabel,
    this.onSelected,
    super.key,
  }) : assert(count > 0),
       assert(index >= 0 && index < count);

  final int count;
  final int index;
  final String semanticLabel;
  final String Function(int current, int total) positionLabel;
  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context) => CallbackShortcuts(
    bindings: {
      const SingleActivator(LogicalKeyboardKey.arrowLeft): () {
        if (onSelected != null && index > 0) onSelected!(index - 1);
      },
      const SingleActivator(LogicalKeyboardKey.arrowRight): () {
        if (onSelected != null && index < count - 1) onSelected!(index + 1);
      },
    },
    child: Semantics(
      key: const Key('lesson-pager-semantics'),
      container: true,
      label: semanticLabel,
      value: positionLabel(index + 1, count),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          count,
          (dot) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpaceTokens.xs),
            child: Semantics(
              button: true,
              selected: dot == index,
              label: positionLabel(dot + 1, count),
              child: ExcludeSemantics(
                child: CanonicalFocusIndicator(
                  borderRadius: BorderRadius.circular(RadiusTokens.full),
                  child: InkWell(
                    key: ValueKey('lesson-pager-$dot'),
                    onTap: onSelected == null ? null : () => onSelected!(dot),
                    borderRadius: BorderRadius.circular(RadiusTokens.full),
                    child: SizedBox.square(
                      dimension: ControlTokens.minTouchTarget,
                      child: Center(
                        child: Container(
                          width: SpaceTokens.sm,
                          height: SpaceTokens.sm,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: dot == index
                                ? ColorTokens.textPrimary
                                : ColorTokens.border,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
