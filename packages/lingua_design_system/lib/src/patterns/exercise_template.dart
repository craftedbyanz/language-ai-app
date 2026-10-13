import 'package:flutter/material.dart';

import '../adaptive/adaptive_layout.dart';
import '../adaptive/content_constraints.dart';
import '../components/app_header.dart';
import '../components/feedback_sheet.dart';
import '../primitives/app_scaffold.dart';
import '../tokens/generated/design_tokens.dart';

enum ExerciseFeedbackAnchor { bottom, compact, detailed }

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
    this.balancedWorkspace = false,
    this.feedbackAnchor = ExerciseFeedbackAnchor.bottom,
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
  final bool balancedWorkspace;
  final ExerciseFeedbackAnchor feedbackAnchor;

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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final textScale = MediaQuery.textScalerOf(context).scale(1);
                    final balanced =
                        balancedWorkspace &&
                        textScale <= 1.3 &&
                        constraints.maxHeight >=
                            LayoutTokens.answerCardMinHeight * 2 +
                                ControlTokens.minTouchTarget * 2 +
                                SpaceTokens.xxl;
                    if (balanced) {
                      return ContentConstraints(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: SpaceTokens.lg,
                          ),
                          child: SizedBox(
                            height: constraints.maxHeight - SpaceTokens.lg,
                            child: Column(
                              children: [
                                Expanded(child: source),
                                const SizedBox(height: SpaceTokens.lg),
                                Expanded(child: answer),
                                const SizedBox(height: SpaceTokens.lg),
                                Row(
                                  children: [
                                    Expanded(child: hints),
                                    const SizedBox(width: SpaceTokens.sm),
                                    submit,
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      child: ContentConstraints(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: SpaceTokens.xxl,
                          ),
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
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned.fill(
            left: LayoutTokens.marginScreen,
            right: LayoutTokens.marginScreen,
            child: _AnimatedFeedback(
              feedback: feedback,
              anchor: feedbackAnchor,
            ),
          ),
        ],
      ),
    ),
  );
}

class _AnimatedFeedback extends StatefulWidget {
  const _AnimatedFeedback({required this.feedback, required this.anchor});

  final Widget? feedback;
  final ExerciseFeedbackAnchor anchor;

  @override
  State<_AnimatedFeedback> createState() => _AnimatedFeedbackState();
}

class _AnimatedFeedbackState extends State<_AnimatedFeedback>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Widget? _visibleFeedback;

  Object? _identity(Widget? feedback) => feedback == null
      ? null
      : (
          feedback.runtimeType,
          feedback.key,
          feedback is FeedbackSheet ? feedback.variant : null,
        );

  @override
  void initState() {
    super.initState();
    _visibleFeedback = widget.feedback;
    _controller = AnimationController(
      vsync: this,
      value: widget.feedback == null ? 0 : 1,
    )..addStatusListener(_onStatus);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // DD-10 default: motion timing and travel were not measured in the source.
    _controller.duration = MediaQuery.disableAnimationsOf(context)
        ? MotionTokens.fast
        : MotionTokens.sheet;
  }

  @override
  void didUpdateWidget(covariant _AnimatedFeedback oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.feedback case final next?) {
      _visibleFeedback = next;
      if (oldWidget.feedback == null ||
          _identity(oldWidget.feedback) != _identity(next)) {
        _controller.forward(from: 0);
      }
    } else if (oldWidget.feedback != null) {
      _controller.reverse();
    }
  }

  void _onStatus(AnimationStatus status) {
    if (status == AnimationStatus.dismissed && widget.feedback == null) {
      setState(() => _visibleFeedback = null);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedback = _visibleFeedback;
    if (feedback == null) return const SizedBox.shrink();
    return AnimatedBuilder(
      animation: _controller,
      child: SafeArea(
        minimum: const EdgeInsets.symmetric(
          vertical: LayoutTokens.marginScreen,
        ),
        child: Align(
          alignment: Alignment(0, switch (widget.anchor) {
            ExerciseFeedbackAnchor.bottom => 1,
            ExerciseFeedbackAnchor.compact =>
              LayoutTokens.feedbackCompactAlignmentY,
            ExerciseFeedbackAnchor.detailed =>
              LayoutTokens.feedbackDetailedAlignmentY,
          }),
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
      builder: (context, child) {
        final progress = MotionTokens.easing.transform(_controller.value);
        return IgnorePointer(
          ignoring: widget.feedback == null,
          child: ExcludeSemantics(
            excluding: widget.feedback == null,
            child: Opacity(
              opacity: progress,
              child: Transform.translate(
                offset: Offset(
                  0,
                  MediaQuery.disableAnimationsOf(context)
                      ? 0
                      : (1 - progress) * MotionTokens.sheetEnterOffset,
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
