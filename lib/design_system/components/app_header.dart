import 'package:flutter/material.dart';

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
    super.key,
  });

  final AppHeaderVariant variant;
  final VoidCallback onLeadingPressed;
  final String leadingLabel;
  final String? title;
  final Widget? centre;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: LayoutTokens.navBarHeight + ControlTokens.minTouchTarget,
    child: Row(
      children: [
        IconButton(
          tooltip: leadingLabel,
          onPressed: onLeadingPressed,
          icon: Icon(
            variant == AppHeaderVariant.pushed
                ? Icons.chevron_left_rounded
                : Icons.close_rounded,
            size: IconTokens.control,
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

class ProgressStepper extends StatelessWidget {
  const ProgressStepper({
    required this.step,
    required this.count,
    required this.semanticLabel,
    super.key,
  });

  final int step;
  final int count;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticLabel,
    value: '$step/$count',
    child: ExcludeSemantics(
      child: Row(
        children: List.generate(count, (index) {
          final isDone = index < step - 1;
          final isCurrent = index == step - 1;
          return Expanded(
            child: Container(
              height: LayoutTokens.stepperHeight,
              margin: EdgeInsets.only(
                right: index == count - 1 ? 0 : SpaceTokens.xs,
              ),
              decoration: BoxDecoration(
                color: isDone
                    ? FeatureTokens.writingProgress
                    : isCurrent
                    ? FeatureTokens.writingProgressCurrent
                    : ColorTokens.border,
                borderRadius: BorderRadius.circular(RadiusTokens.full),
                border: isCurrent
                    ? Border.all(
                        color: FeatureTokens.writingProgress,
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
