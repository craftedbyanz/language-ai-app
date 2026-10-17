import 'package:flutter/material.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../settings_copy.dart';

class SettingsListScreen extends StatelessWidget {
  const SettingsListScreen({
    required this.copy,
    required this.onBack,
    required this.onLanguagePressed,
    required this.onLessonPressed,
    required this.onAppearancePressed,
    required this.currentLanguage,
    required this.learningLevel,
    required this.onLearningLanguagePressed,
    super.key,
  });

  final SettingsCopy copy;
  final VoidCallback onBack;
  final VoidCallback onLanguagePressed;
  final VoidCallback onLessonPressed;
  final VoidCallback onAppearancePressed;
  final String currentLanguage;
  final String learningLevel;
  final VoidCallback onLearningLanguagePressed;

  @override
  Widget build(BuildContext context) => AppScaffold(
    backgroundColor: ColorTokens.backgroundPlain,
    child: Column(
      children: [
        ContentConstraints.fullWidth(
          child: AppHeader(
            variant: AppHeaderVariant.pushed,
            title: copy.profile,
            centre: Semantics(
              header: true,
              child: Text(
                copy.profile,
                textAlign: TextAlign.center,
                style: TypographyTokens.profileNav,
              ),
            ),
            leadingLabel: copy.back,
            onLeadingPressed: onBack,
            highlightLeading: true,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ContentConstraints.fullWidth(
              child: Padding(
                padding: const EdgeInsets.only(bottom: SpaceTokens.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: SpaceTokens.md),
                    ProfileIdentity(name: copy.guest, plan: copy.free),
                    const SizedBox(height: SpaceTokens.md),
                    ProfileUpgradePreview(
                      title: copy.upgradeTitle,
                      caption: copy.upgradeCaption,
                      action: copy.upgradeAction,
                    ),
                    const SizedBox(height: LayoutTokens.profilePromoSectionGap),
                    _GroupTitle(copy.studying),
                    const SizedBox(height: SpaceTokens.sm),
                    InkWell(
                      onTap: onLearningLanguagePressed,
                      borderRadius: BorderRadius.circular(RadiusTokens.card),
                      child: _LearningLanguageCard(
                        label: copy.learningLanguage,
                        english: copy.english,
                        level: learningLevel,
                      ),
                    ),
                    const SizedBox(height: SpaceTokens.xl),
                    _GroupTitle(copy.general),
                    const SizedBox(height: SpaceTokens.sm),
                    _SettingsGroup(
                      rows: [
                        _row(copy.editProfile, ProfileSettingSymbol.account),
                        _row(
                          copy.lesson,
                          ProfileSettingSymbol.lesson,
                          onLessonPressed,
                        ),
                        _row(copy.voice, ProfileSettingSymbol.voice),
                        _row(
                          copy.appearance,
                          ProfileSettingSymbol.appearance,
                          onAppearancePressed,
                        ),
                        _row(
                          copy.notifications,
                          ProfileSettingSymbol.notification,
                        ),
                        _row(
                          copy.subscription,
                          ProfileSettingSymbol.subscription,
                        ),
                        _row(copy.redeem, ProfileSettingSymbol.redeem),
                        _row(copy.invite, ProfileSettingSymbol.invite),
                        _row(copy.rate, ProfileSettingSymbol.rate),
                        SettingsRow(
                          label: copy.appLanguage,
                          value: currentLanguage,
                          leading: const ProfileSettingIcon(
                            symbol: ProfileSettingSymbol.language,
                          ),
                          compact: true,
                          variant: SettingsRowVariant.navigate,
                          grouped: true,
                          onPressed: onLanguagePressed,
                        ),
                      ],
                    ),
                    const SizedBox(height: SpaceTokens.xl),
                    _GroupTitle(copy.other),
                    const SizedBox(height: SpaceTokens.sm),
                    _SettingsGroup(
                      rows: [
                        _row(copy.feedback, ProfileSettingSymbol.feedback),
                        _row(copy.terms, ProfileSettingSymbol.terms),
                        _row(copy.privacy, ProfileSettingSymbol.privacy),
                        _row(copy.logout, ProfileSettingSymbol.logout),
                      ],
                    ),
                    const SizedBox(height: SpaceTokens.xxl),
                    Center(
                      child: Column(
                        children: [
                          const ProfileBrandMark(),
                          const SizedBox(height: SpaceTokens.sm),
                          Text(
                            copy.version,
                            style: TypographyTokens.profileSection.copyWith(
                              color: ColorTokens.textSecondary,
                            ),
                          ),
                          const SizedBox(height: SpaceTokens.xs),
                          Text(
                            copy.footerCaption,
                            style: TypographyTokens.profileSection.copyWith(
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
      ],
    ),
  );

  SettingsRow _row(
    String label,
    ProfileSettingSymbol symbol, [
    VoidCallback? onPressed,
  ]) => SettingsRow(
    label: label,
    leading: ProfileSettingIcon(symbol: symbol),
    compact: true,
    variant: SettingsRowVariant.navigate,
    grouped: true,
    onPressed: onPressed,
  );
}

class _LearningLanguageCard extends StatelessWidget {
  const _LearningLanguageCard({
    required this.label,
    required this.english,
    required this.level,
  });

  final String label;
  final String english;
  final String level;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '$label: $english, $level',
    child: Container(
      constraints: const BoxConstraints(minHeight: LayoutTokens.rowSettings),
      padding: const EdgeInsets.symmetric(
        horizontal: SpaceTokens.lg,
        vertical: SpaceTokens.md,
      ),
      decoration: BoxDecoration(
        color: ColorTokens.surface,
        border: Border.all(color: FeatureTokens.profileGroupBorder),
        borderRadius: BorderRadius.circular(RadiusTokens.card),
      ),
      child: Row(
        children: [
          const CountryFlagIcon(country: CountryFlag.unitedStates),
          const SizedBox(width: SpaceTokens.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(english, style: TypographyTokens.profileLanguage),
                Text(
                  english,
                  style: TypographyTokens.profileSection.copyWith(
                    color: ColorTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: FeatureTokens.profileLevelFill,
              borderRadius: BorderRadius.circular(RadiusTokens.full),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SpaceTokens.sm,
                vertical: SpaceTokens.xs,
              ),
              child: Text(
                level,
                style: TypographyTokens.profileBadge.copyWith(
                  color: FeatureTokens.profileLevelText,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.rows});
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    position: DecorationPosition.foreground,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(RadiusTokens.card),
      border: Border.all(color: FeatureTokens.profileGroupBorder),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(RadiusTokens.card),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            rows[i],
            if (i < rows.length - 1)
              const Padding(
                padding: EdgeInsets.only(
                  left: SpaceTokens.lg + IconTokens.tile + SpaceTokens.md,
                  right: SpaceTokens.lg,
                ),
                child: Divider(height: 1, color: FeatureTokens.profileDivider),
              ),
          ],
        ],
      ),
    ),
  );
}

class _GroupTitle extends StatelessWidget {
  const _GroupTitle(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Text(
      label,
      style: TypographyTokens.profileSection.copyWith(
        color: ColorTokens.textSecondary,
      ),
    ),
  );
}
