import 'dart:ui';

import 'package:flutter/material.dart';

import '../primitives/canonical_focus_indicator.dart';
import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';
import 'country_flag.dart';
import 'home_dock_icon.dart';

/// Home shortcut to the learning language, separate from the app locale.
class LearningLanguageButton extends StatelessWidget {
  const LearningLanguageButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => CanonicalFocusIndicator(
    borderRadius: BorderRadius.circular(RadiusTokens.control),
    child: SizedBox.square(
      dimension: ControlTokens.minTouchTarget,
      child: IconButton(
        tooltip: label,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        icon: Container(
          width: ControlTokens.learningFlagWidth,
          height: ControlTokens.learningFlagHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorTokens.surface,
            borderRadius: BorderRadius.circular(RadiusTokens.control),
            border: Border.all(color: ColorTokens.border),
          ),
          child: const CountryFlagIcon(country: CountryFlag.unitedStates),
        ),
      ),
    ),
  );
}

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
        style: TypographyTokens.caption.copyWith(
          color: ColorTokens.textSecondary,
        ),
      ),
    ],
  );
}

enum PromptEntryVariant { pill, inline }

class PromptEntry extends StatelessWidget {
  const PromptEntry({
    required this.label,
    required this.semanticLabel,
    this.onPressed,
    this.variant = PromptEntryVariant.pill,
    super.key,
  });
  final PromptEntryVariant variant;
  final String label;
  final String semanticLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (variant == PromptEntryVariant.inline) {
      return Semantics(
        button: true,
        enabled: onPressed != null,
        label: semanticLabel,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(RadiusTokens.full),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: ControlTokens.minTouchTarget,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(label, style: TypographyTokens.bodyStrong),
                ),
                const SizedBox(width: SpaceTokens.sm),
                Container(
                  width: IconTokens.control,
                  height: IconTokens.control,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        FeatureTokens.learningLanguageCta,
                        ColorTokens.primaryTint,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Semantics(
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
              color: FeatureTokens.homePromptEntryFill,
              borderRadius: BorderRadius.all(
                Radius.circular(RadiusTokens.full),
              ),
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
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: IconTokens.inline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Neighbouring cards recede while the active card keeps its true bounds.
class HomeModeDepth extends StatelessWidget {
  const HomeModeDepth({required this.active, required this.child, super.key});
  final bool active;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final reducedMotion = MediaQuery.disableAnimationsOf(context);
    return TweenAnimationBuilder<double>(
      tween: Tween(end: active ? 1 : 0),
      duration: reducedMotion ? Duration.zero : MotionTokens.fast,
      child: child,
      builder: (context, value, child) => Transform.scale(
        scale: reducedMotion
            ? 1
            : lerpDouble(StateTokens.homeInactiveCardScale, 1, value),
        child: Opacity(
          opacity: lerpDouble(StateTokens.homeInactiveCardOpacity, 1, value)!,
          child: ImageFiltered(
            enabled: value < 1,
            imageFilter: ImageFilter.blur(
              sigmaX: (1 - value) * StateTokens.homeInactiveCardBlur,
              sigmaY: (1 - value) * StateTokens.homeInactiveCardBlur,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
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
    this.focusNode,
    this.statesController,
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
  final FocusNode? focusNode;
  final WidgetStatesController? statesController;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: onPressed != null,
    label: '$index, $title, $category, $description, $actionLabel',
    child: CanonicalFocusIndicator(
      borderRadius: BorderRadius.circular(RadiusTokens.heroCard),
      child: Material(
        color: fill,
        borderRadius: BorderRadius.circular(RadiusTokens.heroCard),
        child: InkWell(
          key: ValueKey('mode-card-$index'),
          focusNode: focusNode,
          statesController: statesController,
          onTap: onPressed,
          borderRadius: BorderRadius.circular(RadiusTokens.heroCard),
          child: CustomPaint(
            painter: _ModeCardMotifPainter(foreground),
            child: Container(
              constraints: const BoxConstraints(
                minHeight: LayoutTokens.modeCardMinHeight,
              ),
              padding: const EdgeInsets.all(SpaceTokens.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpaceTokens.md,
                      vertical: SpaceTokens.xs,
                    ),
                    decoration: BoxDecoration(
                      color: foreground.withValues(
                        alpha: StateTokens.homeCardMotifOpacity,
                      ),
                      border: Border.all(
                        color: foreground.withValues(
                          alpha: StateTokens.modeCardDividerOpacity,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(RadiusTokens.full),
                    ),
                    child: Text(
                      category,
                      style: TypographyTokens.microLabel.copyWith(
                        color: foreground,
                      ),
                    ),
                  ),
                  const SizedBox(height: SpaceTokens.lg),
                  Text(
                    title,
                    style: TypographyTokens.display.copyWith(color: foreground),
                  ),
                  Expanded(
                    child: Center(
                      child: ExcludeSemantics(
                        child: Text(
                          index,
                          style: TypographyTokens.homeModeIndex.copyWith(
                            color: foreground.withValues(
                              alpha: StateTokens.modeCardIndexOpacity,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: SpaceTokens.sm),
                  Text(
                    description,
                    style: TypographyTokens.body.copyWith(color: foreground),
                  ),
                  const SizedBox(height: SpaceTokens.lg),
                  Divider(
                    color: foreground.withValues(
                      alpha: StateTokens.modeCardDividerOpacity,
                    ),
                  ),
                  const SizedBox(height: SpaceTokens.sm),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          actionLabel,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TypographyTokens.bodyStrong.copyWith(
                            color: foreground,
                          ),
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
      ),
    ),
  );
}

class _ModeCardMotifPainter extends CustomPainter {
  const _ModeCardMotifPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(RadiusTokens.heroCard),
      ),
    );
    canvas.drawCircle(
      Offset(size.width - SpaceTokens.lg, SpaceTokens.lg),
      LayoutTokens.homeModeMotifSize / 2,
      Paint()
        ..color = color.withValues(alpha: StateTokens.homeCardMotifOpacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = SpaceTokens.xxl,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ModeCardMotifPainter oldDelegate) =>
      oldDelegate.color != color;
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
    child: DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(RadiusTokens.full)),
        boxShadow: ShadowTokens.homeStreak,
      ),
      child: Material(
        color: ColorTokens.surface,
        borderRadius: BorderRadius.circular(RadiusTokens.full),
        elevation: 0,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(RadiusTokens.full),
          child: SizedBox(
            height: ControlTokens.pillSmallHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpaceTokens.md),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.bar_chart_rounded,
                    size: IconTokens.inline,
                    color: ColorTokens.textFaint,
                  ),
                  const SizedBox(width: SpaceTokens.sm),
                  Text(
                    MediaQuery.sizeOf(context).width <
                            LayoutTokens.hideBarCaptionsBelow
                        ? '$count'
                        : semanticLabel,
                    style: TypographyTokens.microLabel.copyWith(
                      color: ColorTokens.textSecondary,
                    ),
                  ),
                  const SizedBox(width: SpaceTokens.xs),
                  const Icon(
                    Icons.local_fire_department_rounded,
                    color: ColorTokens.warning,
                    size: IconTokens.inline,
                  ),
                ],
              ),
            ),
          ),
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
    this.onHistory,
    this.onStreak,
    this.onMenu,
    this.onSettings,
    super.key,
  });

  final int streakCount;
  final String streakLabel;
  final String historyLabel;
  final String menuLabel;
  final String settingsLabel;
  final VoidCallback? onHistory;
  final VoidCallback? onStreak;
  final VoidCallback? onMenu;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) => SizedBox(
    key: const Key('home-glass-dock'),
    height: LayoutTokens.homeDockHeight + LayoutTokens.homeDockFadeHeight,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: GlassTokens.barBlur,
                  sigmaY: GlassTokens.barBlur,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        GlassTokens.homeDockTint.withValues(alpha: 0),
                        GlassTokens.homeDockTint,
                        GlassTokens.homeDockTint,
                      ],
                      stops: const [
                        0,
                        LayoutTokens.homeDockFadeHeight /
                            (LayoutTokens.homeDockHeight +
                                LayoutTokens.homeDockFadeHeight),
                        1,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: SpaceTokens.lg,
          right: SpaceTokens.lg,
          bottom: LayoutTokens.homeDockControlsBottomInset,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _DockButton(
                label: historyLabel,
                action: HomeDockAction.history,
                onPressed: onHistory,
              ),
              _DockButton(
                label: menuLabel,
                action: HomeDockAction.menu,
                onPressed: onMenu,
              ),
              _DockButton(
                label: settingsLabel,
                action: HomeDockAction.profile,
                onPressed: onSettings,
              ),
            ],
          ),
        ),
        Positioned(
          top:
              LayoutTokens.homeDockFadeHeight -
              ControlTokens.pillSmallHeight / 2,
          child: StreakPill(
            count: streakCount,
            semanticLabel: streakLabel,
            onPressed: onStreak,
          ),
        ),
      ],
    ),
  );
}

class _DockButton extends StatelessWidget {
  const _DockButton({
    required this.label,
    required this.action,
    this.onPressed,
  });
  final String label;
  final HomeDockAction action;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isMenu = action == HomeDockAction.menu;
    final radius = BorderRadius.circular(RadiusTokens.full);
    return Tooltip(
      message: label,
      excludeFromSemantics: true,
      child: Semantics(
        button: true,
        enabled: onPressed != null,
        label: label,
        onTap: onPressed,
        excludeSemantics: true,
        child: CanonicalFocusIndicator(
          borderRadius: radius,
          child: Material(
            color: Colors.transparent,
            borderRadius: radius,
            child: InkWell(
              key: ValueKey('home-dock-${action.name}-button'),
              excludeFromSemantics: true,
              onTap: onPressed,
              borderRadius: radius,
              child: ConstrainedBox(
                key: ValueKey('home-dock-${action.name}-hit-target'),
                constraints: const BoxConstraints(
                  minWidth: ControlTokens.minTouchTarget,
                  minHeight: ControlTokens.minTouchTarget,
                ),
                child: Center(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: Ink(
                    key: ValueKey('home-dock-${action.name}-surface'),
                    height: ControlTokens.homeDockButton,
                    width: isMenu ? null : ControlTokens.homeDockButton,
                    decoration: BoxDecoration(
                      color: GlassTokens.homeDockButtonFill,
                      border: Border.all(
                        color: GlassTokens.homeDockButtonBorder,
                      ),
                      borderRadius: radius,
                    ),
                    child: isMenu
                        ? ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: ControlTokens.homeDockMenuMinWidth,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SpaceTokens.md,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HomeDockIcon(action: action),
                                  const SizedBox(width: SpaceTokens.sm),
                                  Text(
                                    label,
                                    key: const Key('home-dock-menu-label'),
                                    style: TypographyTokens.homeDockLabel,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Center(child: HomeDockIcon(action: action)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class MenuShortcut {
  const MenuShortcut({
    required this.label,
    required this.icon,
    required this.iconFill,
    this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color iconFill;
  final VoidCallback? onPressed;
}

class MenuOverlay extends StatelessWidget {
  const MenuOverlay({
    required this.title,
    required this.closeLabel,
    required this.shortcuts,
    required this.onClose,
    super.key,
  });

  final String title;
  final String closeLabel;
  final List<MenuShortcut> shortcuts;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: GlassTokens.menuBlur,
              sigmaY: GlassTokens.menuBlur,
            ),
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    GlassTokens.menuFill,
                    GlassTokens.menuFill,
                    ColorTokens.primaryTint,
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, LayoutTokens.menuListAlignmentY),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpaceTokens.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: LayoutTokens.sheetWidth,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var index = 0; index < shortcuts.length; index++)
                    _MenuShortcutRow(
                      shortcut: shortcuts[index],
                      autofocus: false,
                    ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(SpaceTokens.lg),
            child: TextButton.icon(
              onPressed: onClose,
              icon: const Icon(Icons.stars_rounded, size: IconTokens.inline),
              label: Text(title),
              style: TextButton.styleFrom(
                backgroundColor: GlassTokens.barFill,
                foregroundColor: ColorTokens.textSecondary,
                shape: const StadiumBorder(),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _MenuShortcutRow extends StatelessWidget {
  const _MenuShortcutRow({required this.shortcut, required this.autofocus});

  final MenuShortcut shortcut;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return CanonicalFocusIndicator(
      borderRadius: BorderRadius.circular(RadiusTokens.card),
      child: TextButton(
        autofocus: autofocus,
        onPressed: shortcut.onPressed,
        style: TextButton.styleFrom(
          foregroundColor: ColorTokens.textPrimary,
          disabledForegroundColor: ColorTokens.textPrimary,
          minimumSize: const Size.fromHeight(LayoutTokens.rowMenu),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusTokens.card),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: IconTokens.tile,
              height: IconTokens.tile,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: shortcut.iconFill,
                shape: BoxShape.circle,
              ),
              child: Icon(
                shortcut.icon,
                size: IconTokens.inline,
                color: ColorTokens.textOnPrimary,
              ),
            ),
            const SizedBox(width: SpaceTokens.md),
            Flexible(
              child: Text(shortcut.label, style: TypographyTokens.bodyStrong),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureBanner extends StatelessWidget {
  const FeatureBanner({
    required this.title,
    required this.caption,
    required this.actionLabel,
    required this.onPressed,
    super.key,
  });

  final String title;
  final String caption;
  final String actionLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final accessible = Theme.of(context)
        .extension<DesignTokensTheme>()!
        .accessible;
    return Semantics(
      button: true,
      label: '$title, $caption, $actionLabel',
      child: CanonicalFocusIndicator(
        borderRadius: BorderRadius.circular(RadiusTokens.card),
        child: Material(
          color: accessible.brandFill,
          borderRadius: BorderRadius.circular(RadiusTokens.card),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(RadiusTokens.card),
            child: Container(
              constraints: const BoxConstraints(
                minHeight: LayoutTokens.bannerFeatureHeight,
              ),
              padding: const EdgeInsets.all(SpaceTokens.lg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: FeatureTokens.homeFlashcardGradient,
                ),
                borderRadius: BorderRadius.circular(RadiusTokens.card),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TypographyTokens.heading.copyWith(
                            color: accessible.onBrand,
                          ),
                        ),
                        const SizedBox(height: SpaceTokens.xs),
                        Text(
                          caption,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TypographyTokens.body.copyWith(
                            color: accessible.onBrand,
                          ),
                        ),
                        const SizedBox(height: SpaceTokens.md),
                        ExcludeSemantics(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SpaceTokens.lg,
                              vertical: SpaceTokens.sm,
                            ),
                            decoration: BoxDecoration(
                              color: ColorTokens.surface,
                              borderRadius: BorderRadius.circular(
                                RadiusTokens.full,
                              ),
                            ),
                            child: Text(
                              actionLabel,
                              style: TypographyTokens.bodyStrong.copyWith(
                                color: accessible.link,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: SpaceTokens.sm),
                  const ExcludeSemantics(child: _FlashcardPreview()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FlowLetterTile extends StatelessWidget {
  const FlowLetterTile({
    required this.title,
    required this.caption,
    this.onPressed,
    super.key,
  });

  final String title;
  final String caption;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: onPressed != null,
    label: '$title, $caption',
    child: CanonicalFocusIndicator(
      borderRadius: BorderRadius.circular(RadiusTokens.card),
      child: Material(
        color: FeatureTokens.flowLetterGradientLobby.first,
        borderRadius: BorderRadius.circular(RadiusTokens.card),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(RadiusTokens.card),
          child: Container(
            width: LayoutTokens.historyCardWidth,
            constraints: const BoxConstraints(
              minHeight: LayoutTokens.historyCardHeight,
            ),
            padding: const EdgeInsets.all(SpaceTokens.sm),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: FeatureTokens.flowLetterGradientLobby,
              ),
              borderRadius: BorderRadius.circular(RadiusTokens.card),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExcludeSemantics(
                  child: Row(
                    children: [
                      for (final letter in const ['F', 'L', 'O', 'W']) ...[
                        Container(
                          width: SpaceTokens.lg,
                          height: SpaceTokens.lg,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: GlassTokens.buttonFill,
                            borderRadius: BorderRadius.circular(
                              RadiusTokens.xs,
                            ),
                          ),
                          child: Text(
                            letter,
                            style: TypographyTokens.microLabel.copyWith(
                              color: FeatureTokens.flowLetterGlassText,
                            ),
                          ),
                        ),
                        const SizedBox(width: SpaceTokens.xs),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: SpaceTokens.lg),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TypographyTokens.bodyStrong.copyWith(
                    color: FeatureTokens.flowLetterGlassText,
                  ),
                ),
                const SizedBox(height: SpaceTokens.xs),
                Text(
                  caption,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TypographyTokens.caption.copyWith(
                    color: FeatureTokens.flowLetterGlassText,
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

class _FlashcardPreview extends StatelessWidget {
  const _FlashcardPreview();

  @override
  Widget build(BuildContext context) => SizedBox(
    width: LayoutTokens.historyCardWidth,
    height: LayoutTokens.historyCardHeight,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: SpaceTokens.md,
          right: 0,
          bottom: SpaceTokens.md,
          left: SpaceTokens.md,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ColorTokens.primaryTint,
              borderRadius: BorderRadius.circular(RadiusTokens.card),
            ),
          ),
        ),
        Positioned(
          top: SpaceTokens.xs,
          right: SpaceTokens.md,
          bottom: SpaceTokens.xl,
          left: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ColorTokens.surface,
              borderRadius: BorderRadius.circular(RadiusTokens.card),
              boxShadow: ShadowTokens.raised,
            ),
            child: const Center(
              child: Icon(Icons.style_rounded, size: IconTokens.tile),
            ),
          ),
        ),
      ],
    ),
  );
}
