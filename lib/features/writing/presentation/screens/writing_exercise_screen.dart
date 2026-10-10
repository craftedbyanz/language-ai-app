import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/app_button.dart';
import '../../../../design_system/components/app_header.dart';
import '../../../../design_system/components/exercise_components.dart';
import '../../../../design_system/components/feedback_sheet.dart';
import '../../../../design_system/patterns/exercise_template.dart';
import '../state/writing_exercise_state.dart';
import '../view_models/writing_exercise_view_model.dart';
import '../writing_copy.dart';

class WritingExerciseScreen extends ConsumerStatefulWidget {
  const WritingExerciseScreen({
    required this.lessonId,
    required this.copy,
    required this.onClose,
    super.key,
  });
  final String lessonId;
  final WritingCopy copy;
  final VoidCallback onClose;

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _requestClose(WritingExerciseState state) async {
    final hasInput = switch (state) {
      WritingAnswering(:final answer) => answer.trim().isNotEmpty,
      WritingSubmitting() || WritingFeedback() => true,
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
    final expectedText = switch (state) {
      WritingAnswering(:final answer) => answer,
      WritingSubmitting(:final answer) => answer,
      WritingFeedback(:final answer) => answer,
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
        paletteKey: AnswerPaletteKey.purple,
        controller: _controller,
        label: widget.copy.answerLabel,
        placeholder: widget.copy.answerPlaceholder,
        enabled: state is WritingAnswering,
        onChanged: notifier.answerChanged,
      ),
      hints: HintChipBar(
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
          state: state,
          copy: widget.copy,
          onEdit: notifier.edit,
          onNext: () {
            _controller.clear();
            notifier.next();
          },
        ),
        WritingAnswering() => null,
      },
    );
  }
}

class _ReadyFeedback extends StatelessWidget {
  const _ReadyFeedback({
    required this.state,
    required this.copy,
    required this.onEdit,
    required this.onNext,
  });
  final WritingFeedback state;
  final WritingCopy copy;
  final VoidCallback onEdit;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final correct = state is WritingFeedbackCorrect;
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
