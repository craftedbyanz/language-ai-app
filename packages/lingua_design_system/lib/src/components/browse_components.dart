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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpaceTokens.sm,
                    vertical: SpaceTokens.xs,
                  ),
                  decoration: BoxDecoration(
                    color: ColorTokens.surfaceMuted,
                    borderRadius: BorderRadius.circular(RadiusTokens.chip),
                  ),
                  child: Text(
                    countLabel,
                    style: TypographyTokens.microLabel.copyWith(
                      color: ColorTokens.textSecondary,
                    ),
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

class CollectionHeader extends StatelessWidget {
  const CollectionHeader({
    required this.label,
    required this.title,
    required this.description,
    this.level,
    this.focusNode,
    this.autofocus = false,
    super.key,
  });

  final String label;
  final String title;
  final String description;
  final String? level;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Focus(
      key: const Key('collection-heading-focus'),
      focusNode: focusNode,
      autofocus: autofocus,
      canRequestFocus: focusNode != null,
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: SpaceTokens.sm,
            runSpacing: SpaceTokens.xs,
            children: [
              Text(
                label.toUpperCase(),
                style: TypographyTokens.microLabel.copyWith(
                  color: ColorTokens.textSecondary,
                ),
              ),
              if (level case final value?) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpaceTokens.md,
                    vertical: SpaceTokens.xs,
                  ),
                  decoration: BoxDecoration(
                    color: ColorTokens.surfaceMuted,
                    borderRadius: BorderRadius.circular(RadiusTokens.full),
                  ),
                  child: Text(value, style: TypographyTokens.caption),
                ),
              ],
            ],
          ),
          const SizedBox(height: SpaceTokens.sm),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TypographyTokens.display,
          ),
          const SizedBox(height: SpaceTokens.sm),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TypographyTokens.body.copyWith(
              color: ColorTokens.textSecondary,
            ),
          ),
        ],
      ),
    ),
  );
}

class LessonCard extends StatelessWidget {
  const LessonCard({
    required this.variant,
    required this.indexLabel,
    required this.level,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onPressed,
    this.illustration,
    super.key,
  });
  final LessonCardVariant variant;
  final String indexLabel;
  final String level;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onPressed;
  final Widget? illustration;

  @override
  Widget build(BuildContext context) {
    final accessible =
        Theme.of(context).extension<DesignTokensTheme>()?.accessible ??
        const AccessibleTokens();
    final ctaFill = switch (variant) {
      LessonCardVariant.writing => FeatureTokens.writingCta,
      LessonCardVariant.grammar => FeatureTokens.grammarCta,
      LessonCardVariant.conversation => FeatureTokens.conversationCta,
    };
    final ctaText = variant == LessonCardVariant.grammar
        ? ColorTokens.textPrimary
        : accessible.onBrand;
    return Semantics(
      button: true,
      label: '$indexLabel, $level, $title, $description, $actionLabel',
      child: CanonicalFocusIndicator(
        borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
        child: Material(
          color: ColorTokens.surface,
          borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
            child: _LessonCardContent(
              indexLabel: indexLabel,
              level: level,
              title: title,
              description: description,
              actionLabel: actionLabel,
              illustration: illustration,
              ctaFill: ctaFill,
              ctaText: ctaText,
            ),
          ),
        ),
      ),
    );
  }
}

class _LessonCardContent extends StatelessWidget {
  const _LessonCardContent({
    required this.indexLabel,
    required this.level,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.illustration,
    required this.ctaFill,
    required this.ctaText,
  });

  final String indexLabel;
  final String level;
  final String title;
  final String description;
  final String actionLabel;
  final Widget? illustration;
  final Color ctaFill;
  final Color ctaText;

  @override
  Widget build(BuildContext context) => Container(
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
        const SizedBox(height: SpaceTokens.md),
        Text(title, style: TypographyTokens.title),
        if (illustration case final illustration?)
          Expanded(
            child: Center(child: ExcludeSemantics(child: illustration)),
          )
        else
          const Spacer(),
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
          child: ExcludeSemantics(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: ControlTokens.minTouchTarget,
              ),
              padding: const EdgeInsets.symmetric(horizontal: SpaceTokens.lg),
              decoration: BoxDecoration(
                color: ctaFill,
                borderRadius: BorderRadius.circular(RadiusTokens.full),
              ),
              child: Center(
                widthFactor: 1,
                child: Text(
                  actionLabel,
                  style: TypographyTokens.bodyStrong.copyWith(color: ctaText),
                ),
              ),
            ),
          ),
        ),
      ],
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
            Container(
              width: IconTokens.container + SpaceTokens.lg,
              height: IconTokens.container + SpaceTokens.lg,
              decoration: BoxDecoration(
                color: error ? ColorTokens.errorTint : ColorTokens.surfaceMuted,
                shape: BoxShape.circle,
              ),
              child: Icon(
                error ? Icons.error_outline_rounded : Icons.inbox_outlined,
                size: IconTokens.container,
                color: error
                    ? ColorTokens.errorText
                    : ColorTokens.textSecondary,
              ),
            ),
            const SizedBox(height: SpaceTokens.sm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TypographyTokens.heading,
            ),
            const SizedBox(height: SpaceTokens.xs),
            Text(
              body,
              textAlign: TextAlign.center,
              style: TypographyTokens.body.copyWith(
                color: ColorTokens.textSecondary,
              ),
            ),
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

enum PagerDotsVariant { dashboard, lesson }

class PagerDots extends StatefulWidget {
  const PagerDots({
    required this.count,
    required this.index,
    required this.semanticLabel,
    required this.positionLabel,
    this.variant = PagerDotsVariant.lesson,
    this.onSelected,
    super.key,
  }) : assert(count > 0),
       assert(index >= 0 && index < count);

  final int count;
  final int index;
  final String semanticLabel;
  final String Function(int current, int total) positionLabel;
  final PagerDotsVariant variant;
  final ValueChanged<int>? onSelected;

  @override
  State<PagerDots> createState() => _PagerDotsState();
}

class _PagerDotsState extends State<PagerDots> {
  final _focusNode = FocusNode();
  String get _keyPrefix => widget.variant == PagerDotsVariant.dashboard
      ? 'dashboard-pager'
      : 'lesson-pager';

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CallbackShortcuts(
    bindings: {
      const SingleActivator(LogicalKeyboardKey.arrowLeft): () {
        if (widget.onSelected != null && widget.index > 0) {
          widget.onSelected!(widget.index - 1);
        }
      },
      const SingleActivator(LogicalKeyboardKey.arrowRight): () {
        if (widget.onSelected != null && widget.index < widget.count - 1) {
          widget.onSelected!(widget.index + 1);
        }
      },
    },
    child: Focus(
      focusNode: _focusNode,
      child: Semantics(
        key: Key('$_keyPrefix-semantics'),
        container: true,
        label: widget.semanticLabel,
        value: widget.positionLabel(widget.index + 1, widget.count),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.count,
            (dot) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpaceTokens.xs),
              child: Semantics(
                button: true,
                selected: dot == widget.index,
                label: widget.positionLabel(dot + 1, widget.count),
                child: ExcludeSemantics(
                  child: CanonicalFocusIndicator(
                    borderRadius: BorderRadius.circular(RadiusTokens.full),
                    child: InkWell(
                      key: ValueKey('$_keyPrefix-$dot'),
                      onTap: widget.onSelected == null
                          ? null
                          : () {
                              _focusNode.requestFocus();
                              widget.onSelected!(dot);
                            },
                      borderRadius: BorderRadius.circular(RadiusTokens.full),
                      child: SizedBox.square(
                        dimension: ControlTokens.minTouchTarget,
                        child: Center(
                          child: Container(
                            width: widget.variant == PagerDotsVariant.dashboard
                                ? (dot == widget.index
                                      ? SpaceTokens.xl
                                      : SpaceTokens.xs)
                                : dot == widget.index
                                ? SpaceTokens.lg
                                : SpaceTokens.sm,
                            height: widget.variant == PagerDotsVariant.dashboard
                                ? SpaceTokens.xs
                                : SpaceTokens.sm,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                RadiusTokens.full,
                              ),
                              color: dot == widget.index
                                  ? widget.variant == PagerDotsVariant.dashboard
                                        ? FeatureTokens.grammarAccent
                                        : ColorTokens.textPrimary
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
    ),
  );
}
