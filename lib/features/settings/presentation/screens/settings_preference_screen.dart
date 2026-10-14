import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../../../../core/preferences/device_preferences.dart';

final class SettingsPreferenceCopy {
  const SettingsPreferenceCopy({
    required this.profile,
    required this.lesson,
    required this.appearance,
    required this.inputColor,
    required this.defaultColor,
    required this.green,
    required this.blue,
    required this.purple,
    required this.indigo,
    required this.hintOptions,
    required this.alwaysShowHints,
    required this.alwaysShowHintsCaption,
    required this.cardStyle,
    required this.regular,
    required this.mono,
    required this.minimal,
    required this.glass,
    required this.saveFailed,
  });

  final String profile;
  final String lesson;
  final String appearance;
  final String inputColor;
  final String defaultColor;
  final String green;
  final String blue;
  final String purple;
  final String indigo;
  final String hintOptions;
  final String alwaysShowHints;
  final String alwaysShowHintsCaption;
  final String cardStyle;
  final String regular;
  final String mono;
  final String minimal;
  final String glass;
  final String saveFailed;
}

class SettingsPreferenceScreen extends ConsumerWidget {
  const SettingsPreferenceScreen({
    required this.section,
    required this.copy,
    required this.onBack,
    super.key,
  });

  final String section;
  final SettingsPreferenceCopy copy;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = copy;
    final settings = ref.watch(devicePreferencesProvider);
    final controller = ref.read(devicePreferencesProvider.notifier);
    Future<void> save(Future<void> Function() mutation) async {
      try {
        await mutation();
      } on Exception {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(strings.saveFailed)));
        }
      }
    }

    final lesson = section == 'lesson';
    final title = lesson ? strings.lesson : strings.appearance;
    return AppScaffold(
      backgroundColor: ColorTokens.backgroundPlain,
      child: Column(
        children: [
          ContentConstraints(
            child: AppHeader(
              variant: AppHeaderVariant.pushed,
              title: title,
              leadingLabel: strings.profile,
              onLeadingPressed: onBack,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ContentConstraints(
                child: Padding(
                  padding: const EdgeInsets.all(SpaceTokens.lg),
                  child: lesson
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              strings.inputColor,
                              style: TypographyTokens.heading,
                            ),
                            const SizedBox(height: SpaceTokens.md),
                            _Option(
                              label: strings.defaultColor,
                              selected:
                                  settings.answerPalette ==
                                  LessonInputPalette.defaultColor,
                              onPressed: () => save(controller.resetPalette),
                            ),
                            _Option(
                              label: strings.green,
                              selected:
                                  settings.answerPalette ==
                                  LessonInputPalette.green,
                              onPressed: () => save(
                                () => controller.selectPalette(
                                  LessonInputPalette.green,
                                ),
                              ),
                            ),
                            _Option(
                              label: strings.blue,
                              selected:
                                  settings.answerPalette ==
                                  LessonInputPalette.blue,
                              onPressed: () => save(
                                () => controller.selectPalette(
                                  LessonInputPalette.blue,
                                ),
                              ),
                            ),
                            _Option(
                              label: strings.purple,
                              selected:
                                  settings.answerPalette ==
                                  LessonInputPalette.purple,
                              onPressed: () => save(
                                () => controller.selectPalette(
                                  LessonInputPalette.purple,
                                ),
                              ),
                            ),
                            _Option(
                              label: strings.indigo,
                              selected:
                                  settings.answerPalette ==
                                  LessonInputPalette.indigo,
                              onPressed: () => save(
                                () => controller.selectPalette(
                                  LessonInputPalette.indigo,
                                ),
                              ),
                            ),
                            const SizedBox(height: SpaceTokens.xl),
                            Text(
                              strings.hintOptions,
                              style: TypographyTokens.heading,
                            ),
                            SwitchListTile(
                              title: Text(strings.alwaysShowHints),
                              subtitle: Text(strings.alwaysShowHintsCaption),
                              value: settings.alwaysShowHints,
                              onChanged: (value) => save(
                                () => controller.setAlwaysShowHints(value),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              strings.cardStyle,
                              style: TypographyTokens.heading,
                            ),
                            const SizedBox(height: SpaceTokens.md),
                            for (final (key, label) in [
                              ('regular', strings.regular),
                              ('mono', strings.mono),
                              ('minimal', strings.minimal),
                              ('glass', strings.glass),
                            ])
                              _Option(
                                label: label,
                                selected: settings.cardStyle == key,
                                onPressed: () =>
                                    save(() => controller.selectCardStyle(key)),
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
}

class _Option extends StatelessWidget {
  const _Option({
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: SpaceTokens.sm),
    child: SelectableRow(
      label: label,
      selected: selected,
      onPressed: onPressed,
    ),
  );
}
