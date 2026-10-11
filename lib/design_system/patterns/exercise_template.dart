import 'package:flutter/material.dart';

import '../adaptive/adaptive_layout.dart';
import '../adaptive/content_constraints.dart';
import '../components/app_header.dart';
import '../primitives/app_scaffold.dart';
import '../tokens/generated/design_tokens.dart';

/// Presentational composition for writing and grammar exercises.
class ExerciseTemplate extends StatelessWidget {
  const ExerciseTemplate({
    required this.leadingLabel,
    required this.onClose,
    required this.progress,
    required this.source,
    required this.answer,
    required this.hints,
    required this.submit,
    this.trailing,
    this.feedback,
    super.key,
  });

  final String leadingLabel;
  final VoidCallback onClose;
  final Widget progress;
  final Widget source;
  final Widget answer;
  final Widget hints;
  final Widget submit;
  final Widget? trailing;
  final Widget? feedback;

  @override
  Widget build(BuildContext context) => AppScaffold(
    child: AdaptiveLayout(
      builder: (context, _) => Stack(
        children: [
          Column(
            children: [
              ContentConstraints(
                child: AppHeader(
                  variant: AppHeaderVariant.progress,
                  leadingLabel: leadingLabel,
                  onLeadingPressed: onClose,
                  centre: progress,
                  trailing: trailing,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ContentConstraints(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: SpaceTokens.xxl),
                      child: Column(
                        children: [
                          source,
                          const SizedBox(height: SpaceTokens.lg),
                          answer,
                          const SizedBox(height: SpaceTokens.lg),
                          hints,
                          const SizedBox(height: SpaceTokens.sm),
                          Align(
                            alignment: Alignment.centerRight,
                            child: submit,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (feedback case final feedback?)
            Positioned(
              left: LayoutTokens.marginScreen,
              right: LayoutTokens.marginScreen,
              bottom: LayoutTokens.marginScreen,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: LayoutTokens.sheetWidth,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight:
                          MediaQuery.sizeOf(context).height *
                          LayoutTokens.sheetMaxHeightRatioShort,
                    ),
                    child: SingleChildScrollView(child: feedback),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
