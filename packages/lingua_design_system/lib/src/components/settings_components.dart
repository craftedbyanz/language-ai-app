import 'package:flutter/material.dart';

import '../primitives/canonical_focus_indicator.dart';
import 'country_flag.dart';
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
    this.grouped = false,
    this.leading,
    this.compact = false,
    super.key,
  });

  final String label;
  final String? value;
  final IconData? icon;
  final SettingsRowVariant variant;
  final VoidCallback? onPressed;
  final bool grouped;
  final Widget? leading;
  final bool compact;

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
        borderRadius: grouped ? null : BorderRadius.circular(RadiusTokens.card),
        boxShadow: grouped ? null : ShadowTokens.hairline,
      ),
      child: Row(
        children: [
          if (icon != null || leading != null) ...[
            Container(
              width: IconTokens.tile,
              height: IconTokens.tile,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: compact
                    ? FeatureTokens.profileIconFill
                    : ColorTokens.surfaceMuted,
                shape: BoxShape.circle,
              ),
              child:
                  leading ??
                  Icon(
                    icon,
                    size: IconTokens.inline,
                    color: ColorTokens.textSecondary,
                  ),
            ),
            const SizedBox(width: SpaceTokens.md),
          ],
          Expanded(
            child: Text(
              label,
              style: compact
                  ? TypographyTokens.profileRow
                  : TypographyTokens.bodyStrong,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (value != null) ...[
            const SizedBox(width: SpaceTokens.sm),
            Flexible(
              fit: compact ? FlexFit.tight : FlexFit.loose,
              child: Text(
                value!,
                textAlign: TextAlign.end,
                style:
                    (compact
                            ? TypographyTokens.profileRow
                            : TypographyTokens.body)
                        .copyWith(color: ColorTokens.textSecondary),
              ),
            ),
          ],
          if (variant == SettingsRowVariant.navigate) ...[
            const SizedBox(width: SpaceTokens.sm),
            Icon(
              Icons.chevron_right_rounded,
              size: compact ? IconTokens.profileSetting : IconTokens.inline,
              color: ColorTokens.textFaint,
            ),
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
                color: ColorTokens.surface,
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

class LearningLanguageTile extends StatelessWidget {
  const LearningLanguageTile({
    required this.label,
    required this.nativeLabel,
    required this.flag,
    required this.selected,
    this.comingSoonLabel,
    this.onPressed,
    super.key,
  });
  final String label;
  final String nativeLabel;
  final CountryFlag flag;
  final bool selected;
  final String? comingSoonLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: onPressed != null,
    selected: selected,
    label:
        '$label, $nativeLabel${comingSoonLabel == null ? '' : ', $comingSoonLabel'}',
    excludeSemantics: true,
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
              border: selected ? Border.all(color: ColorTokens.border) : null,
            ),
            child: Row(
              children: [
                CountryFlagIcon(country: flag),
                const SizedBox(width: SpaceTokens.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: SpaceTokens.xs,
                        children: [
                          Text(
                            label,
                            style: TypographyTokens.bodyStrong.copyWith(
                              color: onPressed == null
                                  ? ColorTokens.textSecondary
                                  : ColorTokens.textPrimary,
                            ),
                          ),
                          if (selected)
                            const Icon(
                              Icons.verified_rounded,
                              color: ColorTokens.warning,
                              size: IconTokens.inline,
                            ),
                          if (comingSoonLabel != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SpaceTokens.xs,
                              ),
                              decoration: BoxDecoration(
                                color: ColorTokens.streakBadgeBackground,
                                borderRadius: BorderRadius.circular(
                                  RadiusTokens.full,
                                ),
                              ),
                              child: Text(
                                comingSoonLabel!,
                                style: TypographyTokens.microLabel.copyWith(
                                  color: ColorTokens.warningText,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        nativeLabel,
                        style: TypographyTokens.caption.copyWith(
                          color: ColorTokens.textSecondary,
                        ),
                      ),
                    ],
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
