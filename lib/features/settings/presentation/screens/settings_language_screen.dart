import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../../../../core/preferences/locale_preference.dart';
import '../settings_copy.dart';

class SettingsLanguageScreen extends ConsumerStatefulWidget {
  const SettingsLanguageScreen({
    required this.copy,
    required this.onBack,
    super.key,
  });

  final SettingsCopy copy;
  final VoidCallback onBack;

  @override
  ConsumerState<SettingsLanguageScreen> createState() =>
      _SettingsLanguageScreenState();
}

class _SettingsLanguageScreenState
    extends ConsumerState<SettingsLanguageScreen> {
  late String _pendingLanguage;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _pendingLanguage =
        ref.read(localePreferenceProvider)?.languageCode ??
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    if (_pendingLanguage != 'vi') _pendingLanguage = 'en';
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
    backgroundColor: ColorTokens.backgroundPlain,
    child: Column(
      children: [
        ContentConstraints(
          child: AppHeader(
            variant: AppHeaderVariant.pushed,
            title: widget.copy.appLanguage,
            leadingLabel: widget.copy.title,
            onLeadingPressed: widget.onBack,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ContentConstraints(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      widget.copy.appLanguage,
                      style: TypographyTokens.display,
                    ),
                  ),
                  const SizedBox(height: SpaceTokens.sm),
                  Text(
                    widget.copy.languageCaption,
                    style: TypographyTokens.body.copyWith(
                      color: ColorTokens.textSecondary,
                    ),
                  ),
                  const SizedBox(height: SpaceTokens.xl),
                  SelectableRow(
                    label: widget.copy.english,
                    selected: _pendingLanguage == 'en',
                    onPressed: () => setState(() => _pendingLanguage = 'en'),
                  ),
                  const SizedBox(height: SpaceTokens.sm),
                  SelectableRow(
                    label: widget.copy.vietnamese,
                    selected: _pendingLanguage == 'vi',
                    onPressed: () => setState(() => _pendingLanguage = 'vi'),
                  ),
                  const SizedBox(height: SpaceTokens.xl),
                  AppButton(
                    label: widget.copy.apply,
                    fullWidth: true,
                    onPressed: _saving ? null : _apply,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Future<void> _apply() async {
    setState(() => _saving = true);
    try {
      await ref
          .read(localePreferenceProvider.notifier)
          .select(Locale(_pendingLanguage));
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
