import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lingua_design_system/lingua_design_system.dart';

import '../../../../core/result/result.dart';
import '../../../../core/preferences/device_preferences.dart';
import '../../domain/entities/grammar_content.dart';
import '../../domain/repositories/grammar_repository.dart';
import '../grammar_copy.dart';
import '../providers/grammar_providers.dart';
import '../state/grammar_exercise_state.dart';
import '../state/grammar_correction_diff.dart';
import 'grammar_lesson_list_screen.dart';

class GrammarExerciseScreen extends ConsumerStatefulWidget {
  const GrammarExerciseScreen({
    required this.topicId,
    required this.lessonId,
    required this.copy,
    required this.onBack,
    required this.completionCopy,
    required this.onDone,
    required this.onNextLesson,
    super.key,
  });

  final String topicId;
  final String lessonId;
  final GrammarCopy copy;
  final VoidCallback onBack;
  final CompletionCopy completionCopy;
  final VoidCallback onDone;
  final ValueChanged<String> onNextLesson;

  @override
  ConsumerState<GrammarExerciseScreen> createState() =>
      _GrammarExerciseScreenState();
}

class _GrammarExerciseScreenState extends ConsumerState<GrammarExerciseScreen> {
  final _controller = TextEditingController();
  final _answerFocus = FocusNode();
  final _feedbackTitleFocus = FocusNode();
  final _retryFocus = FocusNode();
  final _submitFocus = FocusNode();
  final _hintFocus = FocusNode();
  var _feedbackOpenedFromHint = false;
  var _restoreSubmitAfterDismissal = false;

  GrammarWorkflowArgs get _args =>
      GrammarWorkflowArgs(topicId: widget.topicId, lessonId: widget.lessonId);

  @override
  void dispose() {
    _controller.dispose();
    _answerFocus.dispose();
    _feedbackTitleFocus.dispose();
    _retryFocus.dispose();
    _submitFocus.dispose();
    _hintFocus.dispose();
    super.dispose();
  }

  void _focus(FocusNode node) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) node.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(grammarExerciseViewModelProvider(_args), (previous, next) {
      if (next is GrammarFailure) {
        _focus(_retryFocus);
      } else if (next is GrammarFeedback || next is GrammarSubmitting) {
        _focus(_feedbackTitleFocus);
      } else if (next is GrammarFeedbackMinimized) {
        _focus(_hintFocus);
      } else if (next is GrammarAnswering) {
        final restoreSubmit =
            previous is GrammarSubmitting ||
            previous is GrammarFailure ||
            _restoreSubmitAfterDismissal;
        _restoreSubmitAfterDismissal = false;
        _focus(restoreSubmit ? _submitFocus : _answerFocus);
      }
    });
    final state = ref.watch(grammarExerciseViewModelProvider(_args));
    final notifier = ref.read(grammarExerciseViewModelProvider(_args).notifier);
    if (state case GrammarUnavailable()) {
      return _Unavailable(copy: widget.copy, onBack: widget.onBack);
    }
    if (state is GrammarInitializationFailure) {
      return _InitializationError(
        copy: widget.copy,
        retryFocusNode: _retryFocus,
        onRetry: notifier.retryInitialization,
        onBack: widget.onBack,
      );
    }
    if (state is GrammarFinished) {
      final lessonsResult = ref
          .watch(grammarRepositoryProvider)
          .loadLessonsForTopic(state.topicId);
      String? nextLessonId;
      if (lessonsResult case Success<List<GrammarLesson>>(
        value: final lessons,
      )) {
        final currentIndex = lessons.indexWhere(
          (lesson) => lesson.id == state.lessonId,
        );
        if (currentIndex >= 0 && currentIndex + 1 < lessons.length) {
          nextLessonId = lessons[currentIndex + 1].id;
        }
      }
      // DD-01 default: completion floats over the lesson list.
      return CompletionTemplate(
        background: GrammarLessonListScreen(
          topicId: state.topicId,
          copy: widget.copy,
          onBack: widget.onDone,
          onLessonPressed: widget.onNextLesson,
        ),
        copy: widget.completionCopy,
        stepsCompleted: state.stepsCompleted,
        corrections: state.corrections,
        onDone: widget.onDone,
        onNextLesson: nextLessonId == null
            ? null
            : () => widget.onNextLesson(nextLessonId!),
      );
    }
    final active = state as GrammarActiveState;
    if (_controller.text != active.answer) {
      _controller.value = TextEditingValue(
        text: active.answer,
        selection: TextSelection.collapsed(offset: active.answer.length),
      );
    }
    final answering = state is GrammarAnswering;
    final submitting = state is GrammarSubmitting;
    final minimized = state is GrammarFeedbackMinimized;
    final dismissed = state is GrammarAnswering && state.lastVerdict != null;
    final canShowFeedback = minimized || dismissed;
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () {
          if (state is GrammarFeedback) {
            notifier.minimize();
          } else if (state is GrammarSubmitting || state is GrammarFailure) {
            notifier.cancel();
          } else {
            widget.onBack();
          }
        },
      },
      child: ExerciseTemplate(
        leadingLabel: widget.copy.close,
        onClose: widget.onBack,
        progress: ProgressStepper(
          variant: ProgressStepperVariant.grammar,
          step: active.step,
          count: active.stepCount,
          semanticLabel: widget.copy.stepOf,
        ),
        source: SourceTextCard(
          variant: SourceTextCardVariant.sentence,
          text: active.exercise.incorrectSentence,
          semanticLabel: widget.copy.sourceSentence,
          instruction: widget.copy.instruction,
          centerContent: true,
        ),
        answer: AnswerInput(
          paletteKey: switch (ref
              .watch(devicePreferencesProvider)
              .answerPalette) {
            LessonInputPalette.defaultColor => AnswerPaletteKey.blue,
            LessonInputPalette.green => AnswerPaletteKey.green,
            LessonInputPalette.blue => AnswerPaletteKey.blue,
            LessonInputPalette.purple => AnswerPaletteKey.purple,
            LessonInputPalette.indigo => AnswerPaletteKey.indigo,
          },
          controller: _controller,
          focusNode: _answerFocus,
          label: widget.copy.answerLabel,
          placeholder: widget.copy.answerPlaceholder,
          enabled: answering,
          centerContent: true,
          onChanged: notifier.answerChanged,
        ),
        hints: HintChipBar(
          revealInitially: ref.watch(devicePreferencesProvider).alwaysShowHints,
          hints: active.exercise.hints,
          hintLabel: (index) => '${widget.copy.hint} ${index + 1}',
          showFeedbackLabel: canShowFeedback ? widget.copy.showFeedback : null,
          showFeedbackFocusNode: _hintFocus,
          onShowFeedback: canShowFeedback
              ? () {
                  _feedbackOpenedFromHint = true;
                  notifier.reopenFeedback();
                }
              : null,
        ),
        submit: SubmitButton(
          focusNode: _submitFocus,
          label: widget.copy.submit,
          loading: submitting,
          onPressed: state is GrammarAnswering && state.canSubmit
              ? notifier.submit
              : null,
        ),
        feedback: switch (state) {
          GrammarSubmitting() => FeedbackSheet.loading(
            gradingLabel: widget.copy.grading,
            cancelLabel: widget.copy.cancel,
            onCancel: notifier.cancel,
            titleFocusNode: _feedbackTitleFocus,
          ),
          GrammarFailure() => InlineError(
            message: widget.copy.errorBody,
            retryLabel: widget.copy.retry,
            cancelLabel: widget.copy.cancel,
            retryFocusNode: _retryFocus,
            onRetry: notifier.retry,
            onCancel: notifier.cancel,
          ),
          GrammarFeedbackCorrect() => FeedbackSheet.grammarCorrect(
            title: widget.copy.correctTitle,
            answer: state.answer,
            recapLabel: widget.copy.yourAnswer,
            analysisLabel: widget.copy.viewAnalysis,
            analysisUnavailableReason: widget.copy.analysisUnavailable,
            nextLabel: widget.copy.next,
            closeLabel: widget.copy.close,
            minimizeLabel: widget.copy.minimizeFeedback,
            onAnalysis: null,
            onNext: () {
              _controller.clear();
              notifier.next();
            },
            onClose: () {
              if (_feedbackOpenedFromHint) {
                _feedbackOpenedFromHint = false;
                notifier.minimize();
              } else {
                _restoreSubmitAfterDismissal = true;
                notifier.dismiss();
              }
            },
            onMinimize: notifier.minimize,
            titleFocusNode: _feedbackTitleFocus,
          ),
          GrammarFeedbackIncorrect() => _IncorrectFeedback(
            state: state,
            copy: widget.copy,
            titleFocusNode: _feedbackTitleFocus,
            onFix: notifier.fix,
            onNext: () {
              _controller.clear();
              notifier.next();
            },
            onClose: () {
              if (_feedbackOpenedFromHint) {
                _feedbackOpenedFromHint = false;
                notifier.minimize();
              } else {
                _restoreSubmitAfterDismissal = true;
                notifier.dismiss();
              }
            },
            onMinimize: notifier.minimize,
          ),
          GrammarAnswering() || GrammarFeedbackMinimized() => null,
        },
        balancedWorkspace: true,
        feedbackAnchor: switch (state) {
          GrammarFeedbackCorrect() => ExerciseFeedbackAnchor.compact,
          GrammarFeedbackIncorrect() ||
          GrammarFailure() => ExerciseFeedbackAnchor.detailed,
          _ => ExerciseFeedbackAnchor.bottom,
        },
      ),
    );
  }
}

class _IncorrectFeedback extends StatelessWidget {
  const _IncorrectFeedback({
    required this.state,
    required this.copy,
    required this.titleFocusNode,
    required this.onFix,
    required this.onNext,
    required this.onClose,
    required this.onMinimize,
  });

  final GrammarFeedbackIncorrect state;
  final GrammarCopy copy;
  final FocusNode titleFocusNode;
  final VoidCallback onFix;
  final VoidCallback onNext;
  final VoidCallback onClose;
  final VoidCallback onMinimize;

  @override
  Widget build(BuildContext context) => FeedbackSheet.grammarIncorrect(
    title: copy.incorrectTitle,
    originalAnswer: state.verdict.originalResponse,
    correctedAnswer: state.verdict.correctedAnswer,
    explanation: state.verdict.explanation,
    bullets: state.verdict.tips,
    sectionLabel: copy.tips,
    correctionLabel: copy.correction,
    correctionSegments: buildGrammarCorrectionDiff(
      original: state.verdict.originalResponse,
      corrected: state.verdict.correctedAnswer,
    ),
    retainedLabel: copy.correctionRetained,
    removedLabel: copy.correctionRemoved,
    insertedLabel: copy.correctionInserted,
    fixLabel: copy.fix,
    nextLabel: copy.next,
    closeLabel: copy.close,
    minimizeLabel: copy.minimizeFeedback,
    onFix: onFix,
    onNext: onNext,
    onClose: onClose,
    onMinimize: onMinimize,
    titleFocusNode: titleFocusNode,
  );
}

class _InitializationError extends StatelessWidget {
  const _InitializationError({
    required this.copy,
    required this.retryFocusNode,
    required this.onRetry,
    required this.onBack,
  });

  final GrammarCopy copy;
  final FocusNode retryFocusNode;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => AppScaffold(
    child: Column(
      children: [
        AppHeader(
          variant: AppHeaderVariant.pushed,
          title: copy.grammar,
          leadingLabel: copy.back,
          onLeadingPressed: onBack,
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(copy.errorTitle, style: TypographyTokens.heading),
                InlineError(
                  message: copy.errorBody,
                  retryLabel: copy.retry,
                  cancelLabel: copy.back,
                  retryFocusNode: retryFocusNode,
                  onRetry: onRetry,
                  onCancel: onBack,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _Unavailable extends StatelessWidget {
  const _Unavailable({required this.copy, required this.onBack});

  final GrammarCopy copy;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => AppScaffold(
    child: Column(
      children: [
        AppHeader(
          variant: AppHeaderVariant.pushed,
          title: copy.grammar,
          leadingLabel: copy.back,
          onLeadingPressed: onBack,
        ),
        Expanded(
          child: EmptyState(
            title: copy.unavailableTitle,
            body: copy.unavailableBody,
          ),
        ),
      ],
    ),
  );
}
