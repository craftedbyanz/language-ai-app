import 'package:flutter/material.dart';

import '../primitives/canonical_focus_indicator.dart';
import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';

enum SettingsRowVariant { navigate, info, account }

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    required this.label,
    required this.variant,
    this.value,
    this.icon,
    this.onPressed,
    super.key,
  });

  final String label;
  final String? value;
  final IconData? icon;
  final SettingsRowVariant variant;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final row = Container(
      constraints: const BoxConstraints(minHeight: LayoutTokens.rowSettings),
      padding: const EdgeInsets.symmetric(
        horizontal: SpaceTokens.lg,
        vertical: SpaceTokens.md,
      ),
      decoration: BoxDecoration(
        color: ColorTokens.surface,
        borderRadius: BorderRadius.circular(RadiusTokens.card),
        boxShadow: ShadowTokens.hairline,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: IconTokens.inline),
            const SizedBox(width: SpaceTokens.md),
          ],
          Expanded(
            child: Text(
              label,
              style: TypographyTokens.bodyStrong,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (value != null) ...[
            const SizedBox(width: SpaceTokens.sm),
            Flexible(
              child: Text(
                value!,
                textAlign: TextAlign.end,
                style: TypographyTokens.body.copyWith(
                  color: ColorTokens.textSecondary,
                ),
              ),
            ),
          ],
          if (variant == SettingsRowVariant.navigate) ...[
            const SizedBox(width: SpaceTokens.sm),
            const Icon(Icons.chevron_right_rounded, size: IconTokens.inline),
          ],
        ],
      ),
    );
    if (variant != SettingsRowVariant.navigate) return row;
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: value == null ? label : '$label, $value',
      child: CanonicalFocusIndicator(
        borderRadius: BorderRadius.circular(RadiusTokens.card),
        child: Material(
          type: MaterialType.transparency,
          borderRadius: BorderRadius.circular(RadiusTokens.card),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(RadiusTokens.card),
            child: row,
          ),
        ),
      ),
    );
  }
}

class SelectableRow extends StatelessWidget {
  const SelectableRow({
    required this.label,
    required this.selected,
    required this.onPressed,
    this.subtitle,
    super.key,
  });

  final String label;
  final String? subtitle;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final accessible = Theme.of(context)
        .extension<DesignTokensTheme>()!
        .accessible;
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      button: true,
      label: subtitle == null ? label : '$label, $subtitle',
      child: CanonicalFocusIndicator(
        borderRadius: BorderRadius.circular(RadiusTokens.card),
        child: Material(
          color: ColorTokens.surface,
          borderRadius: BorderRadius.circular(RadiusTokens.card),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(RadiusTokens.card),
            child: Container(
              constraints: const BoxConstraints(
                minHeight: LayoutTokens.rowSettings,
              ),
              padding: const EdgeInsets.all(SpaceTokens.lg),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(RadiusTokens.card),
                boxShadow: ShadowTokens.hairline,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(label, style: TypographyTokens.bodyStrong),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: TypographyTokens.caption.copyWith(
                              color: ColorTokens.textSecondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    selected
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: selected
                        ? accessible.selectedIndicator
                        : ColorTokens.textMuted,
                    size: IconTokens.inline,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
