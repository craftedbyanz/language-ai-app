import 'package:flutter/material.dart';

import '../components/app_button.dart';
import '../components/insight_components.dart';
import '../tokens/generated/design_tokens.dart';

final class CompletionCopy {
  const CompletionCopy({
    required this.title,
    required this.steps,
    required this.corrections,
    required this.nextLesson,
    required this.done,
  });

  final String title;
  final String steps;
  final String corrections;
  final String nextLesson;
  final String done;
}

/// A static lesson summary over the lesson list, following DD-01.
class CompletionTemplate extends StatelessWidget {
  const CompletionTemplate({
    required this.background,
    required this.copy,
    required this.stepsCompleted,
    required this.corrections,
    required this.onDone,
    this.onNextLesson,
    super.key,
  });

  final Widget background;
  final CompletionCopy copy;
  final int stepsCompleted;
  final int corrections;
  final VoidCallback onDone;
  final VoidCallback? onNextLesson;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Positioned.fill(
        child: ExcludeSemantics(
          child: ExcludeFocus(child: AbsorbPointer(child: background)),
        ),
      ),
      Positioned.fill(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(SpaceTokens.lg),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: LayoutTokens.dialogWidth,
                    maxWidth: LayoutTokens.sheetWidth,
                  ),
                  child: Material(
                    color: ColorTokens.surface,
                    borderRadius: BorderRadius.circular(RadiusTokens.card),
                    elevation: 0,
                    child: Container(
                      padding: const EdgeInsets.all(SpaceTokens.xl),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(RadiusTokens.card),
                        boxShadow: ShadowTokens.floating,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(copy.title, style: TypographyTokens.heading),
                          const SizedBox(height: SpaceTokens.lg),
                          Row(
                            children: [
                              Expanded(
                                child: InsightStatCard(
                                  icon: Icons.check_circle_outline_rounded,
                                  value: '$stepsCompleted',
                                  label: copy.steps,
                                ),
                              ),
                              const SizedBox(width: SpaceTokens.md),
                              Expanded(
                                child: InsightStatCard(
                                  icon: Icons.edit_outlined,
                                  value: '$corrections',
                                  label: copy.corrections,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SpaceTokens.xl),
                          AppButton(
                            label: copy.nextLesson,
                            onPressed: onNextLesson,
                            fullWidth: true,
                            autofocus: onNextLesson != null,
                          ),
                          const SizedBox(height: SpaceTokens.sm),
                          AppButton(
                            label: copy.done,
                            variant: AppButtonVariant.secondary,
                            onPressed: onDone,
                            fullWidth: true,
                            autofocus: onNextLesson == null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
