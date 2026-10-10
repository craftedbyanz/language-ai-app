import 'dart:ui';

import 'package:flutter/material.dart';

import '../tokens/generated/design_tokens.dart';

enum SourceTextCardVariant { paragraph, sentence }

class SourceTextCard extends StatelessWidget {
  const SourceTextCard({
    required this.variant,
    required this.text,
    required this.semanticLabel,
    super.key,
  });
  final SourceTextCardVariant variant;
  final String text;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticLabel,
    readOnly: true,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(SpaceTokens.lg),
      decoration: BoxDecoration(
        color: ColorTokens.surface,
        borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
        boxShadow: ShadowTokens.hairline,
      ),
      child: Text(
        text,
        style: switch (variant) {
          SourceTextCardVariant.paragraph => TypographyTokens.body,
          SourceTextCardVariant.sentence => TypographyTokens.heading,
        },
      ),
    ),
  );
}

enum AnswerPaletteKey { purple, blue, indigo, green, lime, ink, white }

extension AnswerPaletteKeyTokens on AnswerPaletteKey {
  AnswerColors get colors => switch (this) {
    AnswerPaletteKey.purple => AnswerPaletteTokens.purple,
    AnswerPaletteKey.blue => AnswerPaletteTokens.blue,
    AnswerPaletteKey.indigo => AnswerPaletteTokens.indigo,
    AnswerPaletteKey.green => AnswerPaletteTokens.green,
    AnswerPaletteKey.lime => AnswerPaletteTokens.lime,
    AnswerPaletteKey.ink => AnswerPaletteTokens.ink,
    AnswerPaletteKey.white => AnswerPaletteTokens.white,
  };
}

class AnswerInput extends StatelessWidget {
  const AnswerInput({
    required this.paletteKey,
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.onChanged,
    required this.enabled,
    this.autofocus = true,
    super.key,
  });
  final AnswerPaletteKey paletteKey;
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final ValueChanged<String> onChanged;
  final bool enabled;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final palette = paletteKey.colors;
    return Semantics(
      label: label,
      textField: true,
      child: Container(
        key: const Key('answer-input-surface'),
        constraints: const BoxConstraints(
          minHeight: LayoutTokens.answerCardMinHeight,
        ),
        padding: const EdgeInsets.all(SpaceTokens.lg),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
          boxShadow: paletteKey == AnswerPaletteKey.white
              ? ShadowTokens.hairline
              : ShadowTokens.none,
        ),
        child: TextField(
          key: const Key('answer-input'),
          controller: controller,
          autofocus: autofocus,
          enabled: enabled,
          maxLines: null,
          onChanged: onChanged,
          style: TypographyTokens.body.copyWith(color: palette.foreground),
          cursorColor: palette.foreground,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: placeholder,
            hintStyle: TypographyTokens.body.copyWith(
              color: palette.foreground,
            ),
          ),
        ),
      ),
    );
  }
}

class HintChipBar extends StatefulWidget {
  const HintChipBar({required this.hints, required this.hintLabel, super.key});
  final List<String> hints;
  final String Function(int index) hintLabel;

  @override
  State<HintChipBar> createState() => _HintChipBarState();
}

class _HintChipBarState extends State<HintChipBar> {
  final _revealed = <int>{};

  @override
  Widget build(BuildContext context) => SizedBox(
    height: ControlTokens.minTouchTarget,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.hints.length,
      separatorBuilder: (_, _) => const SizedBox(width: SpaceTokens.sm),
      itemBuilder: (context, index) {
        final revealed = _revealed.contains(index);
        return Semantics(
          button: true,
          label: revealed ? widget.hints[index] : widget.hintLabel(index),
          child: ExcludeSemantics(
            child: ActionChip(
              avatar: const Icon(
                Icons.lightbulb_outline_rounded,
                size: IconTokens.inline,
              ),
              label: revealed
                  ? Text(widget.hints[index])
                  : ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: LayoutTokens.hintChipBlur,
                        sigmaY: LayoutTokens.hintChipBlur,
                      ),
                      child: Text(widget.hints[index]),
                    ),
              onPressed: () => setState(() => _revealed.add(index)),
              backgroundColor: ColorTokens.surface,
              side: BorderSide.none,
              shape: const StadiumBorder(),
              labelStyle: TypographyTokens.caption,
            ),
          ),
        );
      },
    ),
  );
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    required this.label,
    required this.onPressed,
    required this.loading,
    super.key,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    enabled: onPressed != null && !loading,
    child: SizedBox.square(
      dimension: ControlTokens.minTouchTarget,
      child: IconButton.filled(
        key: const Key('submit-button'),
        tooltip: label,
        onPressed: loading ? null : onPressed,
        style: IconButton.styleFrom(
          backgroundColor: onPressed == null
              ? ColorTokens.surface
              : ControlStateTokens.submitEnabled,
          foregroundColor: onPressed == null
              ? ControlStateTokens.submitDisabled
              : ColorTokens.textOnPrimary,
          side: onPressed == null
              ? const BorderSide(
                  color: ControlStateTokens.submitDisabled,
                  width: FocusTokens.ringWidth,
                )
              : BorderSide.none,
        ),
        icon: loading
            ? const SizedBox.square(
                dimension: IconTokens.inline,
                child: CircularProgressIndicator(
                  strokeWidth: FocusTokens.ringWidth,
                ),
              )
            : const Icon(Icons.arrow_forward_rounded, size: IconTokens.inline),
      ),
    ),
  );
}
