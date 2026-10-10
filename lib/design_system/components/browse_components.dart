import 'package:flutter/material.dart';

import '../adaptive/window_size_class.dart';
import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';
import 'app_button.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.eyebrow,
    required this.firstLine,
    required this.secondLine,
    required this.sizeClass,
    super.key,
  });
  final String eyebrow;
  final String firstLine;
  final String secondLine;
  final WindowSizeClass sizeClass;

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
                const TextSpan(
                  text: '.',
                  style: TextStyle(color: FeatureTokens.writingAccent),
                ),
              ],
            ),
          ),
        ],
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
