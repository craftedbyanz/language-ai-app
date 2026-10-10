import 'dart:ui';

import 'package:flutter/material.dart';

import '../tokens/generated/design_tokens.dart';

class GreetingBlock extends StatelessWidget {
  const GreetingBlock({
    required this.greeting,
    required this.caption,
    super.key,
  });
  final String greeting;
  final String caption;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Semantics(
        header: true,
        child: Text(greeting, style: TypographyTokens.title),
      ),
      const SizedBox(height: SpaceTokens.xs),
      Text(
        caption,
        style: TypographyTokens.body.copyWith(color: ColorTokens.textSecondary),
      ),
    ],
  );
}

class PromptEntry extends StatelessWidget {
  const PromptEntry({
    required this.label,
    required this.semanticLabel,
    this.onPressed,
    super.key,
  });
  final String label;
  final String semanticLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: onPressed != null,
    label: semanticLabel,
    child: Material(
      color: FeatureTokens.homePromptEntryFill,
      shape: const StadiumBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const StadiumBorder(),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: ControlTokens.minTouchTarget,
          ),
          padding: const EdgeInsets.symmetric(horizontal: SpaceTokens.lg),
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            boxShadow: ShadowTokens.hairline,
          ),
          child: Row(
            children: [
              const Icon(Icons.auto_awesome_rounded, size: IconTokens.inline),
              const SizedBox(width: SpaceTokens.sm),
              Expanded(
                child: Text(
                  label,
                  style: TypographyTokens.body.copyWith(
                    color: ColorTokens.textMuted,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_rounded, size: IconTokens.inline),
            ],
          ),
        ),
      ),
    ),
  );
}

class ModeCard extends StatelessWidget {
  const ModeCard({
    required this.index,
    required this.category,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.fill,
    required this.foreground,
    this.onPressed,
    super.key,
  });
  final String index;
  final String category;
  final String title;
  final String description;
  final String actionLabel;
  final Color fill;
  final Color foreground;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: onPressed != null,
    label: '$index, $title, $category, $description, $actionLabel',
    child: Material(
      color: fill,
      borderRadius: BorderRadius.circular(RadiusTokens.heroCard),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(RadiusTokens.heroCard),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: LayoutTokens.modeCardMinHeight,
          ),
          padding: const EdgeInsets.all(SpaceTokens.xl),
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
                    child: Text(
                      category,
                      style: TypographyTokens.microLabel.copyWith(
                        color: ColorTokens.textPrimary,
                      ),
                    ),
                  ),
                  ExcludeSemantics(
                    child: Text(
                      index,
                      style: TypographyTokens.display.copyWith(
                        color: ColorTokens.textFaint,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                style: TypographyTokens.display.copyWith(color: foreground),
              ),
              const SizedBox(height: SpaceTokens.sm),
              Text(
                description,
                style: TypographyTokens.body.copyWith(color: foreground),
              ),
              const SizedBox(height: SpaceTokens.xl),
              Row(
                children: [
                  Text(
                    actionLabel,
                    style: TypographyTokens.bodyStrong.copyWith(
                      color: foreground,
                    ),
                  ),
                  const SizedBox(width: SpaceTokens.xs),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: foreground,
                    size: IconTokens.inline,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class StreakPill extends StatelessWidget {
  const StreakPill({
    required this.count,
    required this.semanticLabel,
    this.onPressed,
    super.key,
  });

  final int count;
  final String semanticLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: onPressed != null,
    label: semanticLabel,
    child: TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.local_fire_department_rounded,
        color: ColorTokens.warning,
        size: IconTokens.inline,
      ),
      label: Text(
        '$count',
        style: TypographyTokens.bodyStrong.copyWith(
          color: ColorTokens.warningText,
        ),
      ),
    ),
  );
}

class FloatingBottomBar extends StatelessWidget {
  const FloatingBottomBar({
    required this.streakCount,
    required this.streakLabel,
    required this.historyLabel,
    required this.menuLabel,
    required this.settingsLabel,
    super.key,
  });

  final int streakCount;
  final String streakLabel;
  final String historyLabel;
  final String menuLabel;
  final String settingsLabel;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(RadiusTokens.full),
    child: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: GlassTokens.barBlur,
        sigmaY: GlassTokens.barBlur,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: SpaceTokens.sm),
        decoration: BoxDecoration(
          color: GlassTokens.barFill,
          borderRadius: BorderRadius.circular(RadiusTokens.full),
          boxShadow: ShadowTokens.hairline,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: historyLabel,
              onPressed: null,
              icon: const Icon(Icons.history_rounded),
            ),
            StreakPill(count: streakCount, semanticLabel: streakLabel),
            IconButton(
              tooltip: menuLabel,
              onPressed: null,
              icon: const Icon(Icons.apps_rounded),
            ),
            IconButton(
              tooltip: settingsLabel,
              onPressed: null,
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
      ),
    ),
  );
}
