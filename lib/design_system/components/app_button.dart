import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';

enum AppButtonVariant { primary, secondary, accent, link }

enum AppButtonAccent { writing, grammar, conversation }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.accent,
    this.fullWidth = false,
    super.key,
  }) : assert(variant != AppButtonVariant.accent || accent != null);

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonAccent? accent;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final accessible =
        Theme.of(context).extension<DesignTokensTheme>()?.accessible ??
        const AccessibleTokens();
    final child = switch (variant) {
      AppButtonVariant.primary => FilledButton(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, ControlTokens.minTouchTarget),
          backgroundColor: ControlStateTokens.actionFill,
          foregroundColor: ControlStateTokens.actionText,
          padding: const EdgeInsets.symmetric(horizontal: SpaceTokens.lg),
          textStyle: TypographyTokens.bodyStrong,
          shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
      AppButtonVariant.secondary => FilledButton(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, ControlTokens.minTouchTarget),
          backgroundColor: ControlStateTokens.secondaryFill,
          foregroundColor: ColorTokens.textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: SpaceTokens.lg),
          textStyle: TypographyTokens.bodyStrong,
          shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
      AppButtonVariant.accent => FilledButton(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, ControlTokens.minTouchTarget),
          backgroundColor: switch (accent!) {
            AppButtonAccent.writing => FeatureTokens.writingCta,
            AppButtonAccent.grammar => FeatureTokens.grammarCta,
            AppButtonAccent.conversation => FeatureTokens.conversationCta,
          },
          foregroundColor: switch (accent!) {
            AppButtonAccent.grammar => ColorTokens.textPrimary,
            AppButtonAccent.writing ||
            AppButtonAccent.conversation => accessible.onBrand,
          },
          padding: const EdgeInsets.symmetric(horizontal: SpaceTokens.lg),
          textStyle: TypographyTokens.bodyStrong,
          shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
      AppButtonVariant.link => TextButton(
        style: TextButton.styleFrom(
          minimumSize: const Size(0, ControlTokens.minTouchTarget),
          foregroundColor: accessible.link,
          textStyle: TypographyTokens.bodyStrong,
          shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    };
    return fullWidth ? SizedBox(width: double.infinity, child: child) : child;
  }
}
