import 'dart:ui' show SemanticsRole;

import 'package:flutter/material.dart';

import '../primitives/canonical_focus_indicator.dart';
import '../tokens/generated/design_tokens.dart';

enum AppHeaderVariant { pushed, progress }

class AppHeader extends StatelessWidget {
  const AppHeader({
    required this.variant,
    required this.onLeadingPressed,
    required this.leadingLabel,
    this.title,
    this.centre,
    this.trailing,
    this.leadingFocusNode,
    super.key,
  });

  final AppHeaderVariant variant;
  final VoidCallback onLeadingPressed;
  final String leadingLabel;
  final String? title;
  final Widget? centre;
  final Widget? trailing;
  final FocusNode? leadingFocusNode;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: LayoutTokens.navBarHeight + ControlTokens.minTouchTarget,
    child: Row(
      children: [
        CanonicalFocusIndicator(
          borderRadius: BorderRadius.circular(RadiusTokens.full),
          child: IconButton(
            key: const Key('app-header-leading'),
            focusNode: leadingFocusNode,
            tooltip: leadingLabel,
            onPressed: onLeadingPressed,
            icon: Icon(
              variant == AppHeaderVariant.pushed
                  ? Icons.chevron_left_rounded
                  : Icons.close_rounded,
              size: IconTokens.control,
            ),
          ),
        ),
        const SizedBox(width: SpaceTokens.sm),
        Expanded(
          child:
              centre ??
              Semantics(
                header: true,
                child: Text(
                  title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TypographyTokens.heading,
                ),
              ),
        ),
        const SizedBox(width: SpaceTokens.sm),
        SizedBox(
          width: ControlTokens.minTouchTarget,
          child: trailing ?? const SizedBox.shrink(),
        ),
      ],
    ),
  );
}

enum ProgressStepperVariant { writing, grammar, scenario }

class ProgressStepper extends StatelessWidget {
  const ProgressStepper({
    required this.variant,
    required this.step,
    required this.count,
    required this.semanticLabel,
    super.key,
  });

  final ProgressStepperVariant variant;
  final int step;
  final int count;
  final String semanticLabel;

  Color get _progressColor => switch (variant) {
    ProgressStepperVariant.writing => FeatureTokens.writingProgress,
    ProgressStepperVariant.grammar => FeatureTokens.grammarProgress,
    ProgressStepperVariant.scenario => FeatureTokens.scenarioProgress,
  };

  Color get _currentColor => switch (variant) {
    ProgressStepperVariant.writing => FeatureTokens.writingProgressCurrent,
    ProgressStepperVariant.grammar => FeatureTokens.grammarProgressCurrent,
    ProgressStepperVariant.scenario => FeatureTokens.scenarioProgressCurrent,
  };

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticLabel,
    value: '$step',
    minValue: '0',
    maxValue: '$count',
    role: SemanticsRole.progressBar,
    liveRegion: true,
    child: ExcludeSemantics(
      child: Row(
        children: List.generate(count, (index) {
          final isDone = index < step - 1;
          final isCurrent = index == step - 1;
          return Expanded(
            child: Container(
              key: ValueKey('progress-segment-$index'),
              height: LayoutTokens.stepperHeight,
              margin: EdgeInsets.only(
                right: index == count - 1 ? 0 : SpaceTokens.xs,
              ),
              decoration: BoxDecoration(
                color: isDone
                    ? _progressColor
                    : isCurrent
                    ? _currentColor
                    : ColorTokens.border,
                borderRadius: BorderRadius.circular(RadiusTokens.full),
                border: isCurrent
                    ? Border.all(
                        color: _progressColor,
                        width: FocusTokens.ringWidth,
                      )
                    : null,
              ),
            ),
          );
        }),
      ),
    ),
  );
}
