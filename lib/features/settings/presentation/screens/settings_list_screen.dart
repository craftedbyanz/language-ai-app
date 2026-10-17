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
        ContentConstraints(
          child: AppHeader(
            variant: AppHeaderVariant.pushed,
            title: copy.profile,
            leadingLabel: copy.back,
            onLeadingPressed: onBack,
            highlightLeading: true,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ContentConstraints(
              child: Padding(
                padding: const EdgeInsets.only(bottom: SpaceTokens.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(SpaceTokens.xs),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: ColorTokens.border),
                                ),
                                child: CircleAvatar(
                                  radius: IconTokens.container,
                                  backgroundColor: ColorTokens.surfaceMuted,
                                  child: Icon(
                                    Icons.person_rounded,
                                    size: IconTokens.container,
                                    color: ColorTokens.textFaint,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -SpaceTokens.xs,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: ColorTokens.surfaceMuted,
                                    borderRadius: BorderRadius.circular(
                                      RadiusTokens.full,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: SpaceTokens.sm,
                                    ),
                                    child: Text(
                                      copy.free,
                                      style: TypographyTokens.microLabel,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SpaceTokens.lg),
                          Text(copy.guest, style: TypographyTokens.heading),
                        ],
                      ),
                    ),
                    const SizedBox(height: SpaceTokens.lg),
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: LayoutTokens.bannerPromoHeight,
                      ),
                      padding: const EdgeInsets.all(SpaceTokens.lg),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            ColorTokens.primary,
                            ColorTokens.primaryStrong,
                            FeatureTokens.conversationHomeCardFill,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(RadiusTokens.card),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.auto_awesome_rounded,
                            color: ColorTokens.textOnPrimary,
                            size: IconTokens.tile,
                          ),
                          const SizedBox(width: SpaceTokens.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  copy.upgradeTitle,
                                  style: TypographyTokens.bodyStrong.copyWith(
                                    color: ColorTokens.textOnPrimary,
                                  ),
                                ),
                                Text(
                                  copy.upgradeCaption,
                                  style: TypographyTokens.caption.copyWith(
                                    color: ColorTokens.textOnPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: ColorTokens.primaryStrong,
                              borderRadius: BorderRadius.circular(
                                RadiusTokens.full,
                              ),
                              border: Border.all(
                                color: ColorTokens.textOnPrimary,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SpaceTokens.md,
                                vertical: SpaceTokens.sm,
                              ),
                              child: Text(
                                copy.upgradeAction,
                                style: TypographyTokens.caption.copyWith(
                                  color: ColorTokens.textOnPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: SpaceTokens.xxl),
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
                        _row(copy.editProfile, Icons.account_circle_outlined),
                        _row(copy.lesson, Icons.tune_rounded, onLessonPressed),
                        _row(copy.voice, Icons.graphic_eq_rounded),
                        _row(
                          copy.appearance,
                          Icons.settings_outlined,
                          onAppearancePressed,
                        ),
                        _row(
                          copy.notifications,
                          Icons.notifications_none_rounded,
                        ),
                        _row(copy.subscription, Icons.wallet_outlined),
                        _row(copy.redeem, Icons.redeem_rounded),
                        _row(copy.invite, Icons.share_outlined),
                        _row(copy.rate, Icons.stars_outlined),
                        SettingsRow(
                          label: copy.appLanguage,
                          value: currentLanguage,
                          icon: Icons.translate_rounded,
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
                        _row(copy.feedback, Icons.feedback_outlined),
                        _row(copy.terms, Icons.description_outlined),
                        _row(copy.privacy, Icons.privacy_tip_outlined),
                        _row(copy.logout, Icons.logout_rounded),
                      ],
                    ),
                    const SizedBox(height: SpaceTokens.xxl),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            copy.version,
                            style: TypographyTokens.caption.copyWith(
                              color: ColorTokens.textSecondary,
                            ),
                          ),
                          const SizedBox(height: SpaceTokens.xs),
                          Text(
                            copy.footerCaption,
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
      ],
    ),
  );

  SettingsRow _row(String label, IconData icon, [VoidCallback? onPressed]) =>
      SettingsRow(
        label: label,
        icon: icon,
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
        border: Border.all(color: ColorTokens.border),
        borderRadius: BorderRadius.circular(RadiusTokens.card),
      ),
      child: Row(
        children: [
          const ExcludeSemantics(
            child: Text('🇺🇸', style: TypographyTokens.heading),
          ),
          const SizedBox(width: SpaceTokens.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(english, style: TypographyTokens.bodyStrong),
                Text(
                  english,
                  style: TypographyTokens.caption.copyWith(
                    color: ColorTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: ColorTokens.surfaceMuted,
              borderRadius: BorderRadius.circular(RadiusTokens.full),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SpaceTokens.sm,
                vertical: SpaceTokens.xs,
              ),
              child: Text(level, style: TypographyTokens.caption),
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
    decoration: BoxDecoration(
      color: ColorTokens.surface,
      borderRadius: BorderRadius.circular(RadiusTokens.card),
      border: Border.all(color: ColorTokens.border),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(RadiusTokens.card),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            rows[i],
            if (i < rows.length - 1)
              const Divider(height: 1, color: ColorTokens.border),
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
      style: TypographyTokens.caption.copyWith(
        color: ColorTokens.textSecondary,
      ),
    ),
  );
}
