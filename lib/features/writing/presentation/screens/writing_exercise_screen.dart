import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lingua_design_system/lingua_design_system.dart';

import '../../../../core/preferences/device_preferences.dart';

import '../state/writing_exercise_state.dart';
import '../view_models/writing_exercise_view_model.dart';
import '../writing_copy.dart';
import 'writing_lesson_list_screen.dart';

class WritingExerciseScreen extends ConsumerStatefulWidget {
  const WritingExerciseScreen({
    required this.lessonId,
    required this.copy,
    required this.onClose,
    required this.completionCopy,
    required this.onDone,
    required this.onNextLesson,
    super.key,
  });
  final String lessonId;
  final WritingCopy copy;
  final VoidCallback onClose;
  final CompletionCopy completionCopy;
  final VoidCallback onDone;
  final ValueChanged<String> onNextLesson;

  @override
  ConsumerState<WritingExerciseScreen> createState() =>
      _WritingExerciseScreenState();
}

class _WritingExerciseScreenState extends ConsumerState<WritingExerciseScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    unawaited(
      Future<void>.microtask(
        () => ref
            .read(writingExerciseViewModelProvider.notifier)
            .selectLesson(widget.lessonId),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant WritingExerciseScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lessonId != widget.lessonId) {
      _controller.clear();
      ref
          .read(writingExerciseViewModelProvider.notifier)
          .selectLesson(widget.lessonId);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _requestClose(WritingExerciseState state) async {
    final hasInput = switch (state) {
      WritingAnswering(:final answer) => answer.trim().isNotEmpty,
      WritingSubmitting() || WritingFeedback() => true,
      WritingFinished() => false,
    };
    if (!hasInput) {
      widget.onClose();
      return;
    }
    final shouldLeave = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(widget.copy.leaveExercise),
        content: Text(widget.copy.leaveBody),
        actions: [
          AppButton(
            label: widget.copy.stay,
            variant: AppButtonVariant.secondary,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          AppButton(
            label: widget.copy.leave,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    if (shouldLeave ?? false) widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(writingExerciseViewModelProvider);
    final notifier = ref.read(writingExerciseViewModelProvider.notifier);
    if (state is WritingFinished) {
      final lessons = ref
          .watch(writingRepositoryProvider)
          .lessonsForTopic(state.lesson.topicId);
      final currentIndex = lessons.indexWhere(
        (lesson) => lesson.id == state.lesson.id,
      );
      final nextLessonId =
          currentIndex >= 0 && currentIndex + 1 < lessons.length
          ? lessons[currentIndex + 1].id
          : null;
      // DD-01 default: completion floats over the lesson list.
      return CompletionTemplate(
        background: WritingLessonListScreen(
          topicId: state.lesson.topicId,
          copy: widget.copy,
          onBack: widget.onDone,
          onLessonPressed: widget.onNextLesson,
        ),
        copy: widget.completionCopy,
        stepsCompleted: state.stepCount,
        corrections: state.corrections,
        onDone: widget.onDone,
        onNextLesson: nextLessonId == null
            ? null
            : () => widget.onNextLesson(nextLessonId),
      );
    }
    final expectedText = switch (state) {
      WritingAnswering(:final answer) => answer,
      WritingSubmitting(:final answer) => answer,
      WritingFeedback(:final answer) => answer,
      WritingFinished() => '',
    };
    if (_controller.text != expectedText) {
      _controller.value = TextEditingValue(
        text: expectedText,
        selection: TextSelection.collapsed(offset: expectedText.length),
      );
    }
    final canSubmit = state is WritingAnswering && state.canSubmit;
    final submitting = state is WritingSubmitting;
    return ExerciseTemplate(
      leadingLabel: widget.copy.close,
      onClose: () => _requestClose(state),
      progress: ProgressStepper(
        variant: ProgressStepperVariant.writing,
        step: state.step,
        count: state.stepCount,
        semanticLabel: widget.copy.stepOf,
      ),
      trailing: IconButton(
        tooltip: widget.copy.more,
        onPressed: () {},
        icon: const Icon(Icons.more_horiz_rounded),
      ),
      source: SourceTextCard(
        variant: SourceTextCardVariant.paragraph,
        text: state.exercise.sourceText,
        semanticLabel: widget.copy.sourceText,
      ),
      answer: AnswerInput(
        paletteKey: switch (ref
            .watch(devicePreferencesProvider)
            .answerPalette) {
          LessonInputPalette.defaultColor => AnswerPaletteKey.purple,
          LessonInputPalette.green => AnswerPaletteKey.green,
          LessonInputPalette.blue => AnswerPaletteKey.blue,
          LessonInputPalette.purple => AnswerPaletteKey.purple,
          LessonInputPalette.indigo => AnswerPaletteKey.indigo,
        },
        controller: _controller,
        label: widget.copy.answerLabel,
        placeholder: widget.copy.answerPlaceholder,
        enabled: state is WritingAnswering,
        onChanged: notifier.answerChanged,
      ),
      hints: HintChipBar(
        revealInitially: ref.watch(devicePreferencesProvider).alwaysShowHints,
        hints: state.exercise.hints,
        hintLabel: (index) => '${widget.copy.hint} ${index + 1}',
      ),
      submit: SubmitButton(
        label: widget.copy.submit,
        loading: submitting,
        onPressed: canSubmit ? notifier.submit : null,
      ),
      feedback: switch (state) {
        WritingSubmitting() => FeedbackSheet.loading(
          gradingLabel: widget.copy.grading,
          cancelLabel: widget.copy.cancel,
          onCancel: notifier.cancelSubmission,
        ),
        WritingFeedback() => _ReadyFeedback(
          key: ValueKey((
            state.runtimeType,
            state is WritingFeedbackCorrect ? state.stage : null,
          )),
          state: state,
          copy: widget.copy,
          onEdit: notifier.edit,
          onAnalysis: notifier.revealAnalysis,
          onCancelAnalysis: notifier.cancelAnalysis,
          onNext: () {
            _controller.clear();
            notifier.next();
          },
        ),
        WritingAnswering() => null,
        WritingFinished() => null,
      },
      feedbackAnchor: switch (state) {
        WritingFeedbackCorrect(stage: WritingCorrectStage.recap) =>
          ExerciseFeedbackAnchor.compact,
        WritingFeedback() ||
        WritingSubmitting() => ExerciseFeedbackAnchor.detailed,
        _ => ExerciseFeedbackAnchor.bottom,
      },
    );
  }
}

class _ReadyFeedback extends StatelessWidget {
  const _ReadyFeedback({
    required this.state,
    required this.copy,
    required this.onEdit,
    required this.onAnalysis,
    required this.onCancelAnalysis,
    required this.onNext,
    super.key,
  });
  final WritingFeedback state;
  final WritingCopy copy;
  final VoidCallback onEdit;
  final VoidCallback onAnalysis;
  final VoidCallback onCancelAnalysis;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final correct = state is WritingFeedbackCorrect;
    if (state case WritingFeedbackCorrect(stage: final stage)) {
      if (stage == WritingCorrectStage.recap) {
        return FeedbackSheet.writingRecap(
          title: copy.recapTitle,
          answer: state.answer,
          recapLabel: copy.yourAnswer,
          analysisLabel: copy.viewAnalysis,
          onAnalysis: onAnalysis,
          nextLabel: copy.next,
          closeLabel: copy.close,
          onNext: onNext,
          onClose: onEdit,
        );
      }
      if (stage == WritingCorrectStage.analysisLoading) {
        return FeedbackSheet.loading(
          gradingLabel: copy.grading,
          cancelLabel: copy.cancel,
          onCancel: onCancelAnalysis,
        );
      }
    }
    final shared = (
      title: correct ? copy.correctTitle : copy.incorrectTitle,
      correctedAnswer: state.grade.correctedAnswer,
      originalAnswer: state.answer,
      explanation: state.grade.explanation,
      bullets: state.grade.improvements,
    );
    return correct
        ? FeedbackSheet.writingCorrect(
            title: shared.title,
            correctedAnswer: shared.correctedAnswer,
            originalAnswer: shared.originalAnswer,
            explanation: shared.explanation,
            bullets: shared.bullets,
            correctionLabel: copy.correction,
            sectionLabel: copy.improvements,
            editLabel: copy.edit,
            nextLabel: copy.next,
            closeLabel: copy.close,
            onEdit: onEdit,
            onNext: onNext,
            onClose: onEdit,
          )
        : FeedbackSheet.writingIncorrect(
            title: shared.title,
            correctedAnswer: shared.correctedAnswer,
            originalAnswer: shared.originalAnswer,
            explanation: shared.explanation,
            bullets: shared.bullets,
            correctionLabel: copy.correction,
            sectionLabel: copy.improvements,
            editLabel: copy.edit,
            nextLabel: copy.next,
            closeLabel: copy.close,
            onEdit: onEdit,
            onNext: onNext,
            onClose: onEdit,
          );
  }
}
