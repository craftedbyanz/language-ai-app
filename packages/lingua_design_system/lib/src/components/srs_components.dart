import 'package:flutter/material.dart';

import '../primitives/canonical_focus_indicator.dart';
import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';

class SRSCard extends StatelessWidget {
  const SRSCard({
    required this.word,
    required this.pronunciation,
    required this.partOfSpeech,
    required this.translation,
    required this.flipHint,
    required this.flipped,
    required this.onFlip,
    super.key,
  });

  final String word;
  final String pronunciation;
  final String partOfSpeech;
  final String translation;
  final String flipHint;
  final bool flipped;
  final VoidCallback onFlip;

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: LayoutTokens.srsCardAspect,
    child: Stack(
      children: [
        for (final top in [SpaceTokens.md, SpaceTokens.sm])
          Positioned.fill(
            top: top,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ColorTokens.surfaceMuted,
                borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
                border: Border.all(color: ColorTokens.border),
              ),
            ),
          ),
        Positioned.fill(
          bottom: SpaceTokens.md,
          child: Semantics(
            button: true,
            label: flipHint,
            child: CanonicalFocusIndicator(
              borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
              child: Material(
                color: FeatureTokens.srsCardFill,
                borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
                child: InkWell(
                  onTap: onFlip,
                  borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
                  child: Container(
                    padding: const EdgeInsets.all(SpaceTokens.xl),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        RadiusTokens.largeCard,
                      ),
                      boxShadow: ShadowTokens.raised,
                    ),
                    child: AnimatedSwitcher(
                      duration: MediaQuery.disableAnimationsOf(context)
                          ? Duration.zero
                          : MotionTokens.sheet,
                      child: Column(
                        key: ValueKey(flipped),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            flipped ? translation : word,
                            textAlign: TextAlign.center,
                            style: TypographyTokens.title,
                          ),
                          const SizedBox(height: SpaceTokens.lg),
                          Text(
                            flipped ? word : pronunciation,
                            textAlign: TextAlign.center,
                            style: TypographyTokens.body,
                          ),
                          const SizedBox(height: SpaceTokens.sm),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: FeatureTokens.srsPosBadgeBg,
                              borderRadius: BorderRadius.circular(
                                RadiusTokens.chip,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SpaceTokens.sm,
                                vertical: SpaceTokens.xs,
                              ),
                              child: Text(
                                partOfSpeech.toUpperCase(),
                                style: TypographyTokens.microLabel,
                              ),
                            ),
                          ),
                          const SizedBox(height: SpaceTokens.xxl),
                          Text(flipHint, style: TypographyTokens.microLabel),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

enum SRSGrade { again, hard, good, easy }

class SRSGradeButton extends StatelessWidget {
  const SRSGradeButton({
    required this.grade,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final SRSGrade grade;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final fill = switch (grade) {
      SRSGrade.again => GradeTokens.again,
      SRSGrade.hard => GradeTokens.hard,
      SRSGrade.good => GradeTokens.good,
      SRSGrade.easy => GradeTokens.easy,
    };
    final icon = switch (grade) {
      SRSGrade.again => Icons.refresh_rounded,
      SRSGrade.hard => Icons.more_horiz_rounded,
      SRSGrade.good => Icons.check_rounded,
      SRSGrade.easy => Icons.bolt_rounded,
    };
    final foreground = Theme.of(context)
        .extension<DesignTokensTheme>()!
        .accessible
        .onGradeFill;
    return Semantics(
      button: true,
      label: label,
      child: CanonicalFocusIndicator(
        borderRadius: BorderRadius.circular(RadiusTokens.full),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(RadiusTokens.full),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: ControlTokens.gradeButton,
                height: ControlTokens.gradeButton,
                decoration: BoxDecoration(color: fill, shape: BoxShape.circle),
                child: Icon(icon, color: foreground, size: IconTokens.control),
              ),
              const SizedBox(height: SpaceTokens.xs),
              Text(label, style: TypographyTokens.caption),
            ],
          ),
        ),
      ),
    );
  }
}
