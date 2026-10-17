import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../../../../core/preferences/device_preferences.dart';
import '../learning_language_copy.dart';

class LearningLanguageScreen extends ConsumerStatefulWidget {
  const LearningLanguageScreen({
    required this.copy,
    required this.onBack,
    required this.onChooseLevel,
    super.key,
  });

  final LearningLanguageCopy copy;
  final VoidCallback onBack;
  final Future<LearningLevel?> Function(LearningLevel current) onChooseLevel;

  @override
  ConsumerState<LearningLanguageScreen> createState() =>
      _LearningLanguageScreenState();
}

class _LearningLanguageScreenState
    extends ConsumerState<LearningLanguageScreen> {
  late LearningLevel _level;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _level = ref.read(devicePreferencesProvider).learningLevel;
  }

  @override
  Widget build(BuildContext context) {
    final copy = widget.copy;
    return AppScaffold(
      child: Column(
        children: [
          ContentConstraints(
            child: AppHeader(
              variant: AppHeaderVariant.pushed,
              title: copy.title,
              leadingLabel: copy.back,
              onLeadingPressed: widget.onBack,
              highlightLeading: true,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ContentConstraints(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: SpaceTokens.lg),
                    const Icon(
                      Icons.translate_rounded,
                      size: IconTokens.learningLanguageHero,
                      color: FeatureTokens.learningLanguageCta,
                    ),
                    const SizedBox(height: SpaceTokens.lg),
                    Text(
                      copy.chooseLanguage,
                      textAlign: TextAlign.center,
                      style: TypographyTokens.heading,
                    ),
                    const SizedBox(height: SpaceTokens.sm),
                    Text(
                      copy.caption,
                      textAlign: TextAlign.center,
                      style: TypographyTokens.caption.copyWith(
                        color: ColorTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: SpaceTokens.xl),
                    Text(
                      copy.languagesLabel,
                      style: TypographyTokens.bodyStrong,
                    ),
                    const SizedBox(height: SpaceTokens.md),
                    for (
                      var index = 0;
                      index < copy.languageNames.length;
                      index++
                    ) ...[
                      LearningLanguageTile(
                        label: copy.languageNames[index],
                        nativeLabel: copy.nativeNames[index],
                        flag: CountryFlag.values[index],
                        selected: index == 0,
                        comingSoonLabel: index == 0 ? null : copy.comingSoon,
                        onPressed: index == 0 && !_saving ? () {} : null,
                      ),
                      const SizedBox(height: SpaceTokens.md),
                    ],
                    const SizedBox(height: SpaceTokens.lg),
                  ],
                ),
              ),
            ),
          ),
          ContentConstraints(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: SpaceTokens.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SettingsRow(
                    key: const Key('learning-language-level'),
                    label: copy.currentLevel,
                    value: copy.levelNames[_level.index],
                    variant: SettingsRowVariant.navigate,
                    onPressed: _saving ? null : _chooseLevel,
                  ),
                  const SizedBox(height: SpaceTokens.md),
                  AppButton(
                    key: const Key('learning-language-confirm'),
                    variant: AppButtonVariant.accent,
                    accent: AppButtonAccent.learningLanguage,
                    label: copy.confirm,
                    fullWidth: true,
                    onPressed: _saving ? null : _confirm,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _chooseLevel() async {
    final level = await widget.onChooseLevel(_level);
    if (mounted && level != null) setState(() => _level = level);
  }

  Future<void> _confirm() async {
    setState(() => _saving = true);
    try {
      await ref
          .read(devicePreferencesProvider.notifier)
          .selectLearningLevel(_level);
      if (mounted) widget.onBack();
    } on Exception {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(widget.copy.saveFailed)));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class LearningLevelScreen extends StatefulWidget {
  const LearningLevelScreen({
    required this.copy,
    required this.initialLevel,
    required this.onBack,
    required this.onConfirm,
    super.key,
  });
  final LearningLanguageCopy copy;
  final LearningLevel initialLevel;
  final VoidCallback onBack;
  final ValueChanged<LearningLevel> onConfirm;

  @override
  State<LearningLevelScreen> createState() => _LearningLevelScreenState();
}

class _LearningLevelScreenState extends State<LearningLevelScreen> {
  late LearningLevel _level = widget.initialLevel;

  @override
  Widget build(BuildContext context) {
    final copy = widget.copy;
    return AppScaffold(
      child: Column(
        children: [
          ContentConstraints(
            child: AppHeader(
              variant: AppHeaderVariant.pushed,
              title: copy.levelTitle,
              leadingLabel: copy.back,
              onLeadingPressed: widget.onBack,
              highlightLeading: true,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ContentConstraints(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: SpaceTokens.lg),
                    Text(
                      copy.levelIntro,
                      style: TypographyTokens.body.copyWith(
                        color: ColorTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: SpaceTokens.sm),
                    Text(
                      copy.levelPrompt,
                      style: TypographyTokens.caption.copyWith(
                        color: ColorTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(height: SpaceTokens.xl),
                    Text(copy.levelsLabel, style: TypographyTokens.bodyStrong),
                    const SizedBox(height: SpaceTokens.md),
                    for (final level in LearningLevel.values) ...[
                      SelectableRow(
                        label: copy.levelNames[level.index],
                        subtitle: copy.levelDescriptions[level.index],
                        selected: _level == level,
                        onPressed: () => setState(() => _level = level),
                      ),
                      const SizedBox(height: SpaceTokens.md),
                    ],
                  ],
                ),
              ),
            ),
          ),
          ContentConstraints(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: SpaceTokens.md),
              child: AppButton(
                key: const Key('learning-level-confirm'),
                variant: AppButtonVariant.accent,
                accent: AppButtonAccent.learningLanguage,
                label: copy.confirm,
                fullWidth: true,
                onPressed: () => widget.onConfirm(_level),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
