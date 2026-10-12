import 'package:flutter/material.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../settings_copy.dart';

class SettingsListScreen extends StatelessWidget {
  const SettingsListScreen({
    required this.copy,
    required this.onBack,
    required this.onLanguagePressed,
    required this.currentLanguage,
    super.key,
  });

  final SettingsCopy copy;
  final VoidCallback onBack;
  final VoidCallback onLanguagePressed;
  final String currentLanguage;

  @override
  Widget build(BuildContext context) => AppScaffold(
    backgroundColor: ColorTokens.backgroundPlain,
    child: Column(
      children: [
        ContentConstraints(
          child: AppHeader(
            variant: AppHeaderVariant.pushed,
            title: copy.title,
            leadingLabel: copy.back,
            onLeadingPressed: onBack,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ContentConstraints(
              child: Padding(
                padding: const EdgeInsets.only(bottom: SpaceTokens.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(copy.title, style: TypographyTokens.display),
                    ),
                    const SizedBox(height: SpaceTokens.xl),
                    SettingsRow(
                      label: copy.guest,
                      value: copy.guestCaption,
                      icon: Icons.person_outline_rounded,
                      variant: SettingsRowVariant.account,
                    ),
                    const SizedBox(height: SpaceTokens.xl),
                    _GroupTitle(copy.general),
                    const SizedBox(height: SpaceTokens.sm),
                    SettingsRow(
                      label: copy.language,
                      value: currentLanguage,
                      icon: Icons.language_rounded,
                      variant: SettingsRowVariant.navigate,
                      onPressed: onLanguagePressed,
                    ),
                    const SizedBox(height: SpaceTokens.sm),
                    SettingsRow(
                      label: copy.appearance,
                      value: copy.comingSoon,
                      icon: Icons.palette_outlined,
                      variant: SettingsRowVariant.info,
                    ),
                    const SizedBox(height: SpaceTokens.lg),
                    _GroupTitle(copy.learning),
                    const SizedBox(height: SpaceTokens.sm),
                    SettingsRow(
                      label: copy.level,
                      value: copy.comingSoon,
                      icon: Icons.trending_up_rounded,
                      variant: SettingsRowVariant.info,
                    ),
                    const SizedBox(height: SpaceTokens.sm),
                    SettingsRow(
                      label: copy.lesson,
                      value: copy.comingSoon,
                      icon: Icons.tune_rounded,
                      variant: SettingsRowVariant.info,
                    ),
                    const SizedBox(height: SpaceTokens.sm),
                    SettingsRow(
                      label: copy.voice,
                      value: copy.comingSoon,
                      icon: Icons.record_voice_over_outlined,
                      variant: SettingsRowVariant.info,
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
}

class _GroupTitle extends StatelessWidget {
  const _GroupTitle(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Text(label, style: TypographyTokens.heading),
  );
}
