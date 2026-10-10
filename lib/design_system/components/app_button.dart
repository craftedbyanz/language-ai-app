import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';

enum AppButtonVariant { primary, secondary, link }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.fullWidth = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
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
