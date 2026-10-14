import 'dart:ui';

import 'package:flutter/material.dart';

import '../tokens/generated/design_tokens.dart';
import '../primitives/canonical_focus_indicator.dart';

enum SourceTextCardVariant { paragraph, sentence }

class SourceTextCard extends StatelessWidget {
  const SourceTextCard({
    required this.variant,
    required this.text,
    required this.semanticLabel,
    this.instruction,
    this.centerContent = false,
    super.key,
  });
  final SourceTextCardVariant variant;
  final String text;
  final String semanticLabel;
  final String? instruction;
  final bool centerContent;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: centerContent
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          if (instruction case final instruction?) ...[
            Text(
              instruction,
              style: TypographyTokens.caption.copyWith(
                color: ColorTokens.textSecondary,
              ),
            ),
            const SizedBox(height: SpaceTokens.sm),
          ],
          Text(
            text,
            textAlign: centerContent ? TextAlign.center : TextAlign.start,
            style: switch (variant) {
              SourceTextCardVariant.paragraph => TypographyTokens.body,
              SourceTextCardVariant.sentence => TypographyTokens.heading,
            },
          ),
        ],
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
    this.focusNode,
    this.centerContent = false,
    super.key,
  });
  final AnswerPaletteKey paletteKey;
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final ValueChanged<String> onChanged;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool centerContent;

  @override
  Widget build(BuildContext context) {
    final palette = paletteKey.colors;
    return LayoutBuilder(
      builder: (context, constraints) {
        final expands = centerContent && constraints.hasBoundedHeight;
        return Semantics(
          label: label,
          textField: true,
          child: CanonicalFocusIndicator(
            borderRadius: BorderRadius.circular(RadiusTokens.largeCard),
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
                focusNode: focusNode,
                autofocus: autofocus,
                enabled: enabled,
                expands: expands,
                minLines: expands ? null : 1,
                maxLines: null,
                textAlign: centerContent ? TextAlign.center : TextAlign.start,
                textAlignVertical: expands
                    ? TextAlignVertical.center
                    : TextAlignVertical.top,
                onChanged: onChanged,
                style: TypographyTokens.body.copyWith(
                  color: palette.foreground,
                ),
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
          ),
        );
      },
    );
  }
}

class HintChipBar extends StatefulWidget {
  const HintChipBar({
    required this.hints,
    required this.hintLabel,
    this.revealInitially = false,
    this.showFeedbackLabel,
    this.onShowFeedback,
    this.showFeedbackFocusNode,
    super.key,
  });
  final List<String> hints;
  final String Function(int index) hintLabel;
  final bool revealInitially;
  final String? showFeedbackLabel;
  final VoidCallback? onShowFeedback;
  final FocusNode? showFeedbackFocusNode;

  @override
  State<HintChipBar> createState() => _HintChipBarState();
}

class _HintChipBarState extends State<HintChipBar> {
  final _revealed = <int>{};

  @override
  void initState() {
    super.initState();
    if (widget.revealInitially) {
      _revealed.addAll(List.generate(widget.hints.length, (index) => index));
    }
  }

  @override
  void didUpdateWidget(covariant HintChipBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.revealInitially && !oldWidget.revealInitially) {
      _revealed.addAll(List.generate(widget.hints.length, (index) => index));
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: ControlTokens.minTouchTarget,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.hints.length + (widget.onShowFeedback == null ? 0 : 1),
      separatorBuilder: (_, _) => const SizedBox(width: SpaceTokens.sm),
      itemBuilder: (context, index) {
        if (widget.onShowFeedback != null && index == 0) {
          return CanonicalFocusIndicator(
            borderRadius: BorderRadius.circular(RadiusTokens.full),
            child: ActionChip(
              key: const Key('show-last-feedback'),
              focusNode: widget.showFeedbackFocusNode,
              avatar: const Icon(Icons.auto_awesome_rounded),
              label: Text(widget.showFeedbackLabel!),
              onPressed: widget.onShowFeedback,
            ),
          );
        }
        final hintIndex = index - (widget.onShowFeedback == null ? 0 : 1);
        final revealed = _revealed.contains(hintIndex);
        return Semantics(
          button: true,
          label: revealed
              ? widget.hints[hintIndex]
              : widget.hintLabel(hintIndex),
          child: ExcludeSemantics(
            child: CanonicalFocusIndicator(
              borderRadius: BorderRadius.circular(RadiusTokens.full),
              child: ActionChip(
                avatar: const Icon(
                  Icons.lightbulb_outline_rounded,
                  size: IconTokens.inline,
                ),
                label: revealed
                    ? Text(widget.hints[hintIndex])
                    : ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: LayoutTokens.hintChipBlur,
                          sigmaY: LayoutTokens.hintChipBlur,
                        ),
                        child: Text(widget.hints[hintIndex]),
                      ),
                onPressed: () => setState(() => _revealed.add(hintIndex)),
                backgroundColor: ColorTokens.surface,
                side: BorderSide.none,
                shape: const StadiumBorder(),
                labelStyle: TypographyTokens.caption,
              ),
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
    this.focusNode,
    super.key,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    enabled: onPressed != null && !loading,
    child: CanonicalFocusIndicator(
      borderRadius: BorderRadius.circular(RadiusTokens.full),
      child: SizedBox.square(
        dimension: ControlTokens.minTouchTarget,
        child: IconButton.filled(
          key: const Key('submit-button'),
          focusNode: focusNode,
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
              : const Icon(
                  Icons.arrow_forward_rounded,
                  size: IconTokens.inline,
                ),
        ),
      ),
    ),
  );
}
